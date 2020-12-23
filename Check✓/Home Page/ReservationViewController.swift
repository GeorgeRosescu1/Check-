//
//  ReservationViewController.swift
//  Check✓
//
//  Created by George Rosescu on 17.12.2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField
import Firebase

class ReservationViewController: UIViewController {
    @IBOutlet weak var checkerNameLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    
    @IBOutlet weak var dayTextField: MDCOutlinedTextField!
    @IBOutlet weak var hourTextField: MDCOutlinedTextField!
    @IBOutlet weak var guestsNumberTextField: MDCOutlinedTextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var restaurant: Restaurant?
    var checker: Checker?
    
    var reservation = Reservation()
    
    //MARK: Pickers
    var dayPicker = UIDatePicker()
    var hourPicker = UIDatePicker()
    var guestsPicker = UIPickerView()
    
    let hourFormatter = DateFormatter()
    let dayFormatter = DateFormatter()
    
    var pickerRows = ["1", "2", "3", "4"]
    
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayTextField.delegate = self
        hourTextField.delegate = self
        guestsNumberTextField.delegate = self
        
        guestsPicker.delegate = self
        guestsPicker.dataSource = self
        
        dayPicker.addTarget(self, action: #selector(changeReservationDay), for: .valueChanged)
        dayPicker.datePickerMode = .date
        dayPicker.sizeToFit()
        dayPicker.minimumDate = Date()
        dayPicker.locale = .current
        dayPicker.preferredDatePickerStyle = .wheels
        
        hourPicker.addTarget(self, action: #selector(changeReservationHour), for: .valueChanged)
        hourPicker.datePickerMode = .time
        hourPicker.sizeToFit()
        hourPicker.locale = .current
        hourPicker.preferredDatePickerStyle = .wheels
        
        guestsPicker.sizeToFit()
        
        hourFormatter.dateFormat = "hh:mm"
        hourFormatter.locale = .current
        
        dayFormatter.dateFormat = "MMM-dd-YYYY"
        dayFormatter.locale = .current
        
        reserveButton.layer.cornerRadius = 4
        checkerNameLabel.text = checker!.lastName + " " + checker!.firstName
        restaurantNameLabel.text = restaurant!.name!
        
        configureTextFields()
    }
    
    @objc private func changeReservationDay() {
        let hour = Calendar.current.date(byAdding: .hour, value: 0, to: dayPicker.date)
        if let hour = hour {
            let time = dayFormatter.string(from: hour)
            reservation.day = time
            dayTextField.text = time
        }
    }
    
    @objc private func changeReservationHour() {
        let hour = Calendar.current.date(byAdding: .hour, value: 0, to: hourPicker.date)
        if let hour = hour {
            let time = hourFormatter.string(from: hour)
            reservation.hour = time
            hourTextField.text = time
        }
    }
    
    @objc private func doneAction() {
        self.self.view.findFirstResponder()?.resignFirstResponder()
    }
    
    private func configureTextFields() {
        self.view.addSubview(dayTextField.configureAuthenticationTextField(labelText: "Rezervation day", placeholderText: "21.12.2020", leadingAssistiveLabel: nil))
        self.view.addSubview(hourTextField.configureAuthenticationTextField(labelText: "Rezervation hour", placeholderText: "09:42", leadingAssistiveLabel: nil))
        self.view.addSubview(guestsNumberTextField.configureAuthenticationTextField(labelText: "Number of guests", placeholderText: nil, leadingAssistiveLabel: "Due to current situation the maximum number is 4"))
        
        let toolbar = UIToolbar()
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
        
        toolbar.sizeToFit()
        toolbar.isTranslucent = true
        toolbar.items = [done]
        
        dayTextField.inputAccessoryView = toolbar
        hourTextField.inputAccessoryView = toolbar
        guestsNumberTextField.inputAccessoryView = toolbar
        
        dayTextField.returnKeyType = .next
        hourTextField.returnKeyType = .next
        guestsNumberTextField.returnKeyType = .go
        
        dayTextField.inputView = dayPicker
        hourTextField.inputView = hourPicker
        guestsNumberTextField.inputView = guestsPicker
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reserveAction(_ sender: UIButton) {
        reservation.ownerEmail = checker?.email
        reservation.restaurantEmail = restaurant?.email
        reservation.status = .init_
        reservation.restaurantName = restaurant?.name
        reservation.id = UUID().uuidString
        
        spinner.startAnimating()
        
        let data: [String: Any] = [
            ReservationConstants.FStore.id: self.reservation.id!,
            ReservationConstants.FStore.ownerEmail: self.reservation.ownerEmail!,
            ReservationConstants.FStore.restaurantEmail: self.reservation.restaurantEmail!,
            ReservationConstants.FStore.day: self.reservation.day!,
            ReservationConstants.FStore.hour: self.reservation.hour!,
            ReservationConstants.FStore.numberOfGuests: self.reservation.numberOfGuests ?? 1,
            ReservationConstants.FStore.restaurantName: self.reservation.restaurantName!,
            ReservationConstants.FStore.status: self.reservation.status.rawValue
        ]
        
        self.firestore.collection(ReservationConstants.FStore.collectionName).addDocument(data: data) { (error) in
            self.spinner.stopAnimating()
            if let error = error {
                SwiftMessagesAlert.displaySmallErrorWithBody(error.localizedDescription)
            } else {
                SwiftMessagesAlert.displaySmallSuccessWithBody("Reservation Done! You will be notified after confirmation.")
                self.navigationController?.popViewController(animated: true)
                let currentUser = Session.registeredUser as? Checker
                currentUser?.myRezervations?.append(self.reservation)
                Session.registeredUser = currentUser
            }
        }
    }
}

extension ReservationViewController: UITextFieldDelegate {
}

extension ReservationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerRows.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerRows[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guestsNumberTextField.text = pickerRows[row]
        reservation.numberOfGuests = Int(pickerRows[row])!
    }
}
