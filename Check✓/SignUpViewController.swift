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
    let emailToolbar = UIToolbar()
    let passwordToolbar = UIToolbar()
    let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(toolbarNextAction(_:)))
    let showPassword = UIBarButtonItem(title: "Show password", style: .plain, target: self, action: #selector(showPassword(_:)))
    
    var isToolbarShowButtonVisible = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        configureUI()
        configureTextFields()
        
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        if !textFieldsAreCompleted {
            AlertMessages.displaySmallErrorWithBody("Text fields are mandatory")
        } else {
            
        }
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureTextFields() {
        
        self.view.addSubview(emailTextField.configureAuthenticationTextField(labelText: Constants.emailLabel, placeholderText: Constants.emailPlaceholder, leadingAssistiveLabel: Constants.emailLeadingAssistiveLabel))
        self.view.addSubview(passwordTextField.configureAuthenticationTextField(labelText: Constants.passwordLabel, placeholderText: Constants.passwordPlaceholder, leadingAssistiveLabel: Constants.passwordLeadingAssistiveLabel))
        
        passwordTextField.isSecureTextEntry = true
        
        nextButton.tintColor = #colorLiteral(red: 0.05882352941, green: 0.1882352941, blue: 0.3411764706, alpha: 1)
        showPassword.tintColor = #colorLiteral(red: 0.05882352941, green: 0.1882352941, blue: 0.3411764706, alpha: 1)
        
        emailToolbar.items = [nextButton]
        emailToolbar.sizeToFit()
        emailToolbar.isTranslucent = true
        emailTextField.inputAccessoryView = emailToolbar
        
        passwordToolbar.sizeToFit()
        passwordToolbar.isTranslucent = true
        passwordToolbar.items = [showPassword]
        passwordTextField.inputAccessoryView = passwordToolbar
        
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .go
    }
    
    private func configureUI() {
        signUpButton.layer.cornerRadius = 8
        signUpButton.layer.shadowOpacity = 0.2
        signUpButton.layer.shadowRadius = 16
        signUpButton.alpha = 0.8
        
        logoImageView.layer.cornerRadius = 8
        
    }
    
    @objc func showPassword(_ sender: UITextField) {
        if isToolbarShowButtonVisible {
            showPassword.title = "Hide password"
            passwordTextField.isSecureTextEntry = false
        } else {
            showPassword.title = "Show password"
            passwordTextField.isSecureTextEntry = true
        }
        isToolbarShowButtonVisible = !isToolbarShowButtonVisible
    }
    
    @objc func toolbarNextAction(_ sender: UITextField) {
        passwordTextField.becomeFirstResponder()
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            return true
        }
        
        return true
    }
    
}

private struct Constants {
    
    static let emailLabel = "Email address"
    static let emailPlaceholder = "example@mail.com"
    static let emailLeadingAssistiveLabel = "You will use your email address to log in."
    
    static let passwordLabel = "Password"
    static let passwordPlaceholder: String? = nil
    static let passwordLeadingAssistiveLabel = "Min six characters, one digit and one upper letter."
}
