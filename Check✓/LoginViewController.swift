//
//  LoginViewController.swift
//  Check✓
//
//  Created by George Rosescu on 25/10/2020.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.label.text = "Email address"
        emailTextField.setFloatingLabelColor(.white, for: .editing)
        emailTextField.setFloatingLabelColor(.white, for: .normal)
        emailTextField.setNormalLabelColor(.gray, for: .normal)
        emailTextField.placeholder = "example@mail.com"
        
    }

    @IBAction func goToRegister(_ sender: UIButton) {
        guard let registerVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController else { return }
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
