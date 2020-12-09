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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = Session.registeredUser as? Checker
        configureUI()
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
