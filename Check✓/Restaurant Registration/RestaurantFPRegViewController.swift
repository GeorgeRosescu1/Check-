//
//  RestaurantFPRegViewController.swift
//  Check✓
//
//  Created by George Rosescu on 16.11.2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField

class RestaurantFPRegViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var restaurantNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var restaurantAddressTextField: MDCOutlinedTextField!
    @IBOutlet weak var openHourTextField: MDCOutlinedTextField!
    @IBOutlet weak var closingHourTextField: MDCOutlinedTextField!
    
    //MARK: Visibility controller
    var restaurantRegistrationFPageVC: TTInputVisibilityController!
    
    var restaurantToRegister = Restaurant()
    
    var formIsCompleted: Bool = false
    
    //MARK: Pickers
    var openingHourDatePicker: UIDatePicker?
    var closingHourDatePicker: UIDatePicker?
    
    let timeFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantRegistrationFPageVC = self.view.addInputVisibilityController()
        restaurantRegistrationFPageVC.extraSpaceAboveKeyboard = 10
        
        nextButton.configureRoundButtonWithShadow()
        //        nextButton.isUserInteractionEnabled = false
        //        nextButton.alpha = 0.7
        
        restaurantNameTextField.delegate = self
        restaurantAddressTextField.delegate = self
        openHourTextField.delegate = self
        closingHourTextField.delegate = self
        
        openingHourDatePicker = UIDatePicker()
        openingHourDatePicker?.addTarget(self, action: #selector(changeOpeningTime), for: .valueChanged)
        openingHourDatePicker?.datePickerMode = .time
        openingHourDatePicker?.sizeToFit()
        openingHourDatePicker?.locale = .current
        openingHourDatePicker?.preferredDatePickerStyle = .wheels
        
        closingHourDatePicker = UIDatePicker()
        closingHourDatePicker?.addTarget(self, action: #selector(changeClosingTime), for: .valueChanged)
        closingHourDatePicker?.datePickerMode = .time
        closingHourDatePicker?.sizeToFit()
        closingHourDatePicker?.locale = .current
        closingHourDatePicker?.preferredDatePickerStyle = .wheels
        
        
        timeFormatter.dateFormat = "hh:mm"
        timeFormatter.locale = .current
        
        configureTextFields()
    }
    
    private func configureTextFields() {
        
        self.view.addSubview(restaurantNameTextField.configureAuthenticationTextField(labelText: RestaurantRegisterFormConstants.restaurantName, placeholderText: RestaurantRegisterFormConstants.frestaurantNamePlaceholder, leadingAssistiveLabel: nil))
        
        self.view.addSubview(restaurantAddressTextField.configureAuthenticationTextField(labelText: RestaurantRegisterFormConstants.restaurantAddress, placeholderText: RestaurantRegisterFormConstants.restaurantAddressPlaceholder, leadingAssistiveLabel: nil))
        
        self.view.addSubview(openHourTextField.configureAuthenticationTextField(labelText: RestaurantRegisterFormConstants.openHour, placeholderText: RestaurantRegisterFormConstants.openHourPlaceholder, leadingAssistiveLabel: nil))
        
        self.view.addSubview(closingHourTextField.configureAuthenticationTextField(labelText: RestaurantRegisterFormConstants.closingHour, placeholderText: RestaurantRegisterFormConstants.closingHourPlaceholder, leadingAssistiveLabel: nil))
        
        let toolbar = UIToolbar()
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
        
        toolbar.sizeToFit()
        toolbar.isTranslucent = true
        toolbar.items = [done]
        
        openHourTextField.inputAccessoryView = toolbar
        closingHourTextField.inputAccessoryView = toolbar
        
        restaurantNameTextField.returnKeyType = .next
        restaurantAddressTextField.returnKeyType = .next
        openHourTextField.returnKeyType = .next
        closingHourTextField.returnKeyType = .done
        
        restaurantNameTextField.autocapitalizationType = .words
        openHourTextField.inputView = openingHourDatePicker
        closingHourTextField.inputView = closingHourDatePicker
        restaurantAddressTextField.autocapitalizationType = .words
    }
    
    func validateFormData() {
        guard let restaurantNameText = restaurantNameTextField.text else { return  }
        guard let restaurantAddressText = restaurantAddressTextField.text else { return  }
        
        if !restaurantNameText.isEmpty && !restaurantAddressText.isEmpty {
            nextButton.isUserInteractionEnabled = true
            nextButton.alpha = 1
        } else {
            nextButton.isUserInteractionEnabled = false
            nextButton.alpha = 0.7
        }
    }
    
    @objc private func doneAction() {
        view.findFirstResponder()?.resignFirstResponder()
    }
    
    @objc private func changeOpeningTime() {
        let hour = Calendar.current.date(byAdding: .hour, value: 0, to: openingHourDatePicker!.date)
        if let hour = hour {
            let time = timeFormatter.string(from: hour)
            restaurantToRegister.openingHour = time
            openHourTextField.text = time
        }
    }
    
    @objc private func changeClosingTime() {
        let hour = Calendar.current.date(byAdding: .hour, value: 0, to: closingHourDatePicker!.date)
        if let hour = hour {
            let time = timeFormatter.string(from: hour)
            restaurantToRegister.closingHour = time
            closingHourTextField.text = time
        }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        restaurantNameTextField.endEditing(true)
        restaurantAddressTextField.endEditing(true)
        openHourTextField.endEditing(true)
        closingHourTextField.endEditing(true)
        
        guard let secondPageForm = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "RestaurantSPRegViewController") as? RestaurantSPRegViewController else { return }
        
        secondPageForm.restaurantToRegister = self.restaurantToRegister
        
        navigationController?.pushViewController(secondPageForm, animated: false)
    }
}

struct RestaurantRegisterFormConstants {
    
    static let restaurantName = "Restaurant Name"
    static let frestaurantNamePlaceholder = "Your restaurant name"
    
    static let restaurantAddress = "Restaurant Address"
    static let restaurantAddressPlaceholder = "Your restaurant address"
    
    static let restaurantDescription = "Restaurant description"
    static let restaurantDescriptionPlaceholder = "Tell us some words about your restaurant"
    
    static let openHour = "Open hour"
    static let openHourPlaceholder = "Open Hour"
    
    static let closingHour = "Open hour"
    static let closingHourPlaceholder = "Open Hour"
    
    static let restaurantPhone = "Phone number"
    static let restaurantPhonePlaceholder = "Phone number"
}
