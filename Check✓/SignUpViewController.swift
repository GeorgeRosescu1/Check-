//
//  RegisterViewController.swift
//  Check✓
//
//  Created by George Rosescu on 25/10/2020.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    
    var textFieldsAreCompleted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureKeyboardToolbar()
        
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        if !textFieldsAreCompleted {
            // if both -> alert, if one -> message on that one
            MesssagesHandler.displaySmallErrorWithBody("Text fields are mandatory")
        } else {
            print("Ready to sign up")
        }
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureUI() {
        signUpButton.layer.cornerRadius = 8
        signUpButton.layer.shadowOpacity = 0.2
        signUpButton.layer.shadowRadius = 16
        signUpButton.alpha = 0.8
        
        logoImageView.layer.cornerRadius = 8
        
        self.view.addSubview(emailTextField.configureAuthenticationTextField(labelText: Constants.emailLabel, placeholderText: Constants.emailPlaceholder, leadingAssistiveLabel: Constants.emailLeadingAssistiveLabel))
        
        self.view.addSubview(passwordTextField.configureAuthenticationTextField(labelText: Constants.passwordLabel, placeholderText: Constants.passwordPlaceholder, leadingAssistiveLabel: Constants.passwordLeadingAssistiveLabel))
    }
    
    private func configureKeyboardToolbar() {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(toolbarDoneAction(_:)))
        
        doneButton.tintColor = #colorLiteral(red: 0.05882352941, green: 0.1882352941, blue: 0.3411764706, alpha: 1)
        toolbar.items = [doneButton]
        toolbar.sizeToFit()
        toolbar.isTranslucent = true
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
    }
    
    
    @objc func toolbarDoneAction(_ sender: UITextField) {
        [emailTextField, passwordTextField].forEach { $0?.resignFirstResponder() }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
}

private struct Constants {
    
    static let emailLabel = "Email address"
    static let emailPlaceholder = "example@mail.com"
    static let emailLeadingAssistiveLabel = "You will use your email address to log in."
    
    static let passwordLabel = "Password"
    static let passwordPlaceholder: String? = nil
    static let passwordLeadingAssistiveLabel = "Min six characters, one digit and one upper letter."
}
