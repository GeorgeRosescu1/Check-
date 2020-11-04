//
//  CheckerProfileViewController.swift
//  Check✓
//
//  Created by George Rosescu on 04/11/2020.
//

import Foundation
import UIKit

class CheckerProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
