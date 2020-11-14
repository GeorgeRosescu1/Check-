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
    
    let currentUserEmail = Auth.auth().currentUser?.email
    
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateProfileData()
        
    }
    
    
    private func populateProfileData() {
        let checker = Checker()
        checker.email = currentUserEmail
        
        //listen for updates here
        firestore.collection(CheckerConstants.FStore.collectionName).getDocuments { (snapshot, error) in
            if let error = error {
                SwiftMessagesAlert.displaySmallErrorWithBody(error.localizedDescription)
            } else {
                let currentUserDocument = snapshot?.documents.first(where: { (docData) -> Bool in
                    let document = docData.data()
                    return document[CheckerConstants.FStore.email] as? String == self.currentUserEmail
                })
                
                let currentUserData = currentUserDocument?.data()
                
                checker.firstName = currentUserData?[CheckerConstants.FStore.firstName] as? String
                
                DispatchQueue.main.async {
                    self.userNameLabel.text = checker.firstName
                }
                 
            }
        }
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        Alerts.presentAlertWithOneMainAction(withTitle: "Log out", message: "Are you sure you want to log out?", mainAction: logoutConfirmed, actionTitle: "Log out", fromVC: self)
    }
    
    func logoutConfirmed() {
        FirebaseAuth.logout()
        guard let loginVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
