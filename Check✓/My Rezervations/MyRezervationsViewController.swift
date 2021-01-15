//
//  MyRezervationsViewController.swift
//  Check✓
//
//  Created by George Rosescu on 09.12.2020.
//

import Foundation
import UIKit

class MyRezervationsViewController: UIViewController {
    
    @IBOutlet weak var numberOfRezervationsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ongoingRezervationView: UIView!
    @IBOutlet weak var endRezervationButton: UIButton!
    @IBOutlet weak var ongoingLabel: UILabel!
    
    var currentUser: Checker?
    var reservations = [Reservation]()
    var reservationIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = Session.registeredUser as? Checker
        if let myRezervations = currentUser?.myRezervations {
            reservations = myRezervations.reversed()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "ReservationCell", bundle: nil), forCellReuseIdentifier: "ReservationCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        restaurantNameLabel.text = "No ongoing reservations"
        
        currentUser = Session.registeredUser as? Checker
        if let myRezervations = currentUser?.myRezervations {
            reservations = myRezervations.reversed()
        }
        
        configureUI()
        tableView.reloadData()
    }
    
    @IBAction func endReservationAction(_ sender: UIButton) {
        self.restaurantNameLabel.isHidden = false
        self.restaurantNameLabel.text = "No ongoing reservations"
    }
    
    private func configureUI() {
        if currentUser?.myRezervations?.count == 0 {
            endRezervationButton.isHidden = true
            ongoingLabel.text = "There are no ongoing rezervation"
            restaurantNameLabel.isHidden = true
        }
        
        numberOfRezervationsLabel.text = "You have \(currentUser?.myRezervations?.count ?? 0) rezervations"
    }
}

extension MyRezervationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell") as! ReservationCell
        
        cell.hourLabel.text = reservations[indexPath.row].hour
        cell.dateLabel.text = reservations[indexPath.row].day
       // cell.statusLabel.text = reservations[indexPath.row].status.rawValue
        cell.restaurantNameLabel.text = reservations[indexPath.row].restaurantName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let start = UITableViewRowAction(style: .default, title: "Start") { (row, index) in
            if self.restaurantNameLabel.text == "No ongoing reservations" {
                self.restaurantNameLabel.isHidden = false
                self.restaurantNameLabel.text = "At \(self.reservations[editActionsForRowAt.row].restaurantName!)"
                self.reservationIndex = editActionsForRowAt.row
            }
        }
        start.backgroundColor = .lightGray
        
        
        let cancel = UITableViewRowAction(style: .default, title: "Cancel Reservation") { (row, index) in
            if let index = self.reservationIndex, index == editActionsForRowAt.row {
                self.restaurantNameLabel.isHidden = false
                self.restaurantNameLabel.text = "No ongoing reservations"
                
            }
        }
        cancel.backgroundColor = .red
        
        return [start, cancel]
    }
    
    
}
