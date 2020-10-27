//
//  RegisterViewController.swift
//  Check✓
//
//  Created by George Rosescu on 25/10/2020.
//

import UIKit
import MaterialComponents.MaterialTextFields


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    var emailMaterialTextField = MDCOutlinedTextField(frame: CGRect(x: 33, y: 263, width: 349, height: 34))
    var passwordMaterialTextField = MDCOutlinedTextField(frame: CGRect(x: 33, y: 354, width: 349, height: 34))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        print("Sign up")
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureUI() {
        signUpButton.layer.cornerRadius = 8
        signUpButton.layer.shadowOpacity = 0.2
        signUpButton.layer.shadowRadius = 16
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.8
        
        logoImageView.layer.cornerRadius = 8
        
        emailMaterialTextField.label.text = "Email address"
        emailMaterialTextField.setFloatingLabelColor(.white, for: .editing)
        emailMaterialTextField.setFloatingLabelColor(.white, for: .normal)
        emailMaterialTextField.setNormalLabelColor(.gray, for: .normal)
        emailMaterialTextField.placeholder = "example@mail.com"
        emailMaterialTextField.leadingAssistiveLabel.text = "Your email address. You will log in with it."
        emailMaterialTextField.setLeadingAssistiveLabelColor(.white, for: .editing)
        emailMaterialTextField.setLeadingAssistiveLabelColor(.white, for: .normal)
        emailMaterialTextField.leadingAssistiveLabel.isHidden = true
        emailMaterialTextField.setOutlineColor(.gray, for: .normal)
        emailMaterialTextField.setOutlineColor(.white, for: .editing)
        emailMaterialTextField.setTextColor(.white, for: .normal)
        emailMaterialTextField.setTextColor(.white, for: .editing)
        emailMaterialTextField.sizeToFit()
        self.view.addSubview(emailMaterialTextField)
        //make custom view with xib to use this in other screens as well
        
        passwordMaterialTextField.label.text = "Password"
        passwordMaterialTextField.setFloatingLabelColor(.white, for: .editing)
        passwordMaterialTextField.setFloatingLabelColor(.white, for: .normal)
        passwordMaterialTextField.setNormalLabelColor(.gray, for: .normal)
        passwordMaterialTextField.leadingAssistiveLabel.text = "Min 6 characters, 1 digit and capital letter."
        passwordMaterialTextField.leadingAssistiveLabel.isHidden = true
        passwordMaterialTextField.setLeadingAssistiveLabelColor(.white, for: .editing)
        passwordMaterialTextField.setLeadingAssistiveLabelColor(.white, for: .normal)
        passwordMaterialTextField.setTextColor(.white, for: .normal)
        passwordMaterialTextField.setTextColor(.white, for: .editing)
        passwordMaterialTextField.setOutlineColor(.gray, for: .normal)
        passwordMaterialTextField.setOutlineColor(.white, for: .editing)
        passwordMaterialTextField.sizeToFit()
        self.view.addSubview(passwordMaterialTextField)
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
}
