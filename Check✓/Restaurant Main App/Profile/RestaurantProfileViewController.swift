//
//  RestaurantProfileViewController.swift
//  Check✓
//
//  Created by George Rosescu on 17.11.2020.
//

import Foundation
import UIKit
import Firebase

class RestaurantProfileViewController: UIViewController {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let currentUserEmail = Auth.auth().currentUser?.email
    
    let firestore = Firestore.firestore()
    
    var currentUser: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantImage.layer.cornerRadius = 10
        restaurantImage.layer.borderWidth = 1
        
        populateProfileData()
    }
    
    private func populateProfileData() {
        guard let currentUser = Session.registeredUser as? Restaurant else { return }
        
        DispatchQueue.main.async {
            self.restaurantNameLabel.text = currentUser.name
            self.descriptionLabel.text = currentUser.description
            self.restaurantAddressLabel.text = currentUser.address
            self.restaurantImage.image = currentUser.profilePicture
        }
        
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        Alerts.presentAlertWithOneMainAction(withTitle: "Log out", message: "Are you sure you want to log out?", mainAction: logoutConfirmed, actionTitle: "Log out", fromVC: self)
    }
    
    func logoutConfirmed() {
        FirebaseAPI.logout()
        
        guard let loginVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
