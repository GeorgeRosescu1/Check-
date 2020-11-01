//
//  CheckerMainPageViewController.swift
//  Check✓
//
//  Created by George Rosescu on 01/11/2020.
//

import Foundation
import UIKit
import Firebase

class CheckerMainPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        FirebaseAuth.logout()
        guard let loginVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
