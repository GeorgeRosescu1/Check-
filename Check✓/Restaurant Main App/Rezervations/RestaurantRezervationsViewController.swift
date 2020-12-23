//
//  RestaurantRezervationsViewController.swift
//  Check✓
//
//  Created by George Rosescu on 17.11.2020.
//

import Foundation
import UIKit

class RestaurantRezervationsViewController: UIViewController {
    
    @IBOutlet weak var noReservationsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var reservations = [Reservation]()
    var currentUser: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "ReservationCell", bundle: nil), forCellReuseIdentifier: "ReservationCell")
    }
    
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.currentUser = Session.registeredUser as? Restaurant
            FirebaseAPI.getAllReservationsForUserEmail(self.currentUser?.email ?? "") { (reservationData) in
                var reservations = [Reservation]()
                reservations = reservationData
                
                self.currentUser!.resrvations = reservations
                Session.registeredUser = self.currentUser
                
                if let myRezervations = self.currentUser?.resrvations {
                    self.reservations = myRezervations.reversed()
                }
                
                self.configureUI()
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureUI() {
        noReservationsView.isHidden = !reservations.isEmpty
    }
}

extension RestaurantRezervationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell") as! ReservationCell
        
        cell.hourLabel.text = reservations[indexPath.row].hour
        cell.dateLabel.text = reservations[indexPath.row].day
        cell.statusLabel.text = reservations[indexPath.row].status.rawValue
        cell.restaurantNameLabel.text = reservations[indexPath.row].restaurantName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let start = UITableViewRowAction(style: .default, title: "Start") { (row, index) in
            print("Start")
        }
        start.backgroundColor = .lightGray
        
        
        let cancel = UITableViewRowAction(style: .default, title: "Reject Reservation") { (row, index) in
            print("Reject")
        }
        cancel.backgroundColor = .red
        
        return [start, cancel]
    }
    
}
