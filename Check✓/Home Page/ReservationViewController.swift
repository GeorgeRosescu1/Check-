//
//  ReservationViewController.swift
//  Check✓
//
//  Created by George Rosescu on 17.12.2020.
//

import Foundation
import UIKit

class ReservationViewController: UIViewController {
    
    @IBOutlet weak var checkerNameLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    
    var restaurant: Restaurant?
    var checker: Checker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reserveButton.layer.cornerRadius = 4
        checkerNameLabel.text = checker!.lastName + " " + checker!.firstName
        restaurantNameLabel.text = restaurant!.name!
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reserveAction(_ sender: UIButton) {
        
    }
}
