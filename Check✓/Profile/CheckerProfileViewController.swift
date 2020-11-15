//
//  CheckerProfileViewController.swift
//  Check✓
//
//  Created by George Rosescu on 04/11/2020.
//

import Foundation
import UIKit
import Firebase

class CheckerProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    let currentUserEmail = Auth.auth().currentUser?.email
    
    let firestore = Firestore.firestore()
    
    var currentUser: Checker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicture.layer.cornerRadius = 10
        
        populateProfileData()
        
    }
    
    private func populateProfileData() {
        currentUser = Session.registeredUser as? Checker
        
        DispatchQueue.main.async {
            self.userNameLabel.text = self.currentUser.firstName + " " + self.currentUser.lastName
            self.phoneLabel.text = "Phone: \(self.currentUser.phoneNumber ?? "")"
            if let age = self.currentUser.age {
                self.ageLabel.text = "Age: \(age)"
            }
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
