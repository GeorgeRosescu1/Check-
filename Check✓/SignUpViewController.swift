//
//  RegisterViewController.swift
//  Check✓
//
//  Created by George Rosescu on 25/10/2020.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    
    
    let emailToolbar = UIToolbar()
    let passwordToolbar = UIToolbar()
    let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(toolbarNextAction(_:)))
    let showPassword = UIBarButtonItem(title: "Show password", style: .plain, target: self, action: #selector(showPassword(_:)))
    
    var isToolbarShowButtonVisible = true
    
    var isPasswordValid = true
    var isEmailValid = true
    var textFieldsAreCompleted = false
    var emailText: String? {
        didSet {
            validateEmail()
        }
    }
    
    var passwordText: String? {
        didSet {
            validatePassword()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let signUpVC = self.view.addInputVisibilityController()
        signUpVC.toBeVisibleView = signUpButton
        signUpVC.extraSpaceAboveKeyboard = 10
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        configureUI()
        configureTextFields()
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        guard textFieldsAreCompleted else {
            AlertMessages.displaySmallErrorWithBody("Text fields are mandatory")
            
            return
        }
        
        guard isEmailValid && isPasswordValid else {
            AlertMessages.displaySmallErrorWithBody("Please fill the registration with valid data")
            
            return
        }
        
        Auth.auth().createUser(withEmail: emailText!, password: passwordText!) { (authResult, error) in
            if let error = error {
                AlertMessages.displaySmallErrorWithBody(error.localizedDescription)
            } else {
                print(authResult)
                AlertMessages.displaySmallErrorWithBody("Success")
            }
            
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
    
    private func validateEmail() {
        //regex
        guard let emailText = emailText else {
            
            return
        }
        
        if emailText.isEmpty {
            emailTextField.leadingAssistiveLabel.text = "Email address is mandatory."
            emailTextField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.8821824193, green: 0.3163513541, blue: 0.4430304468, alpha: 1), for: .normal)
            
            return
        } else if !emailText.contains("@") {
            emailTextField.leadingAssistiveLabel.text = "Please enter a valid email address."
            emailTextField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.8821824193, green: 0.3163513541, blue: 0.4430304468, alpha: 1), for: .normal)
            
            return
        }
        
        isEmailValid = true
    }
    
    private func validatePassword() {
        guard let passwordText = passwordText else {
            
            return
        }
        
        if passwordText.count < 6 {
            passwordTextField.leadingAssistiveLabel.text = "Password should be at least 6 chars long."
            passwordTextField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.8821824193, green: 0.3163513541, blue: 0.4430304468, alpha: 1), for: .normal)
        } else {
            var validation1 = false
            var validation2 = false
            for char in passwordText {
                if char.isUppercase{
                    validation1 = true
                }
                if char >= "0" && char <= "9" {
                    validation2 = true
                }
            }
            
            if !validation1 {
                passwordTextField.leadingAssistiveLabel.text = "Password should contain upper case."
                passwordTextField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.8821824193, green: 0.3163513541, blue: 0.4430304468, alpha: 1), for: .normal)
                
                return
            }
            
            if !validation2 {
                passwordTextField.leadingAssistiveLabel.text = "Password should contain digit."
                passwordTextField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.8821824193, green: 0.3163513541, blue: 0.4430304468, alpha: 1), for: .normal)
                
                return
            }
        }
        isEmailValid = true
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
        
        textFieldsAreCompleted = !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            emailTextField.leadingAssistiveLabel.text = Constants.emailLeadingAssistiveLabel
        case passwordTextField:
            passwordTextField.leadingAssistiveLabel.text = Constants.passwordLeadingAssistiveLabel
        default:
            return true
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailText = emailTextField.text
        case passwordTextField:
            passwordText = passwordTextField.text
        default:
            return
        }
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
