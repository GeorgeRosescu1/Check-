//
//  LoginViewController.swift
//  Check✓
//
//  Created by George Rosescu on 25/10/2020.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func goToRegister(_ sender: UIButton) {
        guard let registerVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController else { return }
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
