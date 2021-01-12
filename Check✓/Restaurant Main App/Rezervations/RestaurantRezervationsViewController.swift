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
    @IBOutlet weak var noResLabel: UILabel!
    
    var reservations = [Reservation]()
    var currentUser: Restaurant?
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { (timer) in
            self.fetchData()
        }
        
        spinner.startAnimating()
        noResLabel.isHidden = true
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "ReservationCell", bundle: nil), forCellReuseIdentifier: "ReservationCell")
    }
    
    override func viewDidLayoutSubviews() {
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    private func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.currentUser = Session.registeredUser as? Restaurant
            FirebaseAPI.getAllReservationsForUserEmail(self.currentUser?.email ?? "") { (reservationData) in
                var reservations = [Reservation]()
                reservations = reservationData
                
                if let _ = self.currentUser {
                    self.currentUser!.resrvations = reservations
                    Session.registeredUser = self.currentUser
                    
                    if let myRezervations = self.currentUser?.resrvations {
                        self.reservations = myRezervations.reversed()
                    }
                    
                    self.configureUI()
                    self.tableView.reloadData()
                    DispatchQueue.main.async {
                        self.spinner.stopAnimating()
                    }
                }
            }
        }
    }
    
    private func configureUI() {
        if reservations.isEmpty {
            noResLabel.isHidden = false
        } else {
            noResLabel.isHidden = true
            noReservationsView.isHidden = true
        }
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
        cell.reservationText.text = "Reserved by"
        cell.restaurantNameLabel.text = reservations[indexPath.row].checkerName
        
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
            self.reservations.remove(at: editActionsForRowAt.row)
            tableView.deleteRows(at: [editActionsForRowAt], with: .bottom)
            self.timer?.invalidate()
        }
        cancel.backgroundColor = .red
        
        return [start, cancel]
    }
    
}
