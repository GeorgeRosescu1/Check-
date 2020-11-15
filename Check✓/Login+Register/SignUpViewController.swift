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
    @IBOutlet weak var buttonSpinner: UIActivityIndicatorView!
    
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
          isEmailValid = validateEmail()
        }
    }
    
    var passwordText: String? {
        didSet {
           isPasswordValid = validatePassword()
        }
    }
    
    var isUserChecker = false
    
    //MARK: Visibility controller
    var signUpVC: TTInputVisibilityController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpVC = self.view.addInputVisibilityController()
        signUpVC.extraSpaceAboveKeyboard = 10
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        configureUI()
        configureTextFields()
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        
        guard textFieldsAreCompleted else {
            SwiftMessagesAlert.displaySmallErrorWithBody("Text fields are mandatory")
            
            return
        }
        
        guard isEmailValid && isPasswordValid else {
            SwiftMessagesAlert.displaySmallErrorWithBody("Please fill the registration with valid data")
            
            return
        }
        
        buttonSpinner.startAnimating()
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.7
        emailTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        
        
        FirebaseAuth.signUpUserWithEmail(emailText!, password: passwordText!) { (signUpModel) in
            self.buttonSpinner.stopAnimating()
            self.signUpButton.isEnabled = true
            self.signUpButton.alpha = 1
            self.emailTextField.isUserInteractionEnabled = true
            self.passwordTextField.isUserInteractionEnabled = true
            
            if let error = signUpModel.error {
                SwiftMessagesAlert.displaySmallErrorWithBody(error.localizedDescription)
            } else {
                self.navigateToRegistrationForm()
            }
        }
    }
    
    private func navigateToRegistrationForm() {
        if isUserChecker {
            guard let firstRegistrationPageVc = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "CheckerFirstPageRegistrationViewController") as? CheckerFirstPageRegistrationViewController else { return }
            
            firstRegistrationPageVc.checkerToRegister = Checker()
            firstRegistrationPageVc.checkerToRegister.email = emailText
            
            self.navigationController?.pushViewController(firstRegistrationPageVc, animated: true)
        } else {
           //navigate to restaurnat regisration
        }
    }
    
    private func configureTextFields() {
        
        self.view.addSubview(emailTextField.configureAuthenticationTextField(labelText: SignUpConstants.emailLabel, placeholderText: SignUpConstants.emailPlaceholder, leadingAssistiveLabel: SignUpConstants.emailLeadingAssistiveLabel))
        self.view.addSubview(passwordTextField.configureAuthenticationTextField(labelText: SignUpConstants.passwordLabel, placeholderText: SignUpConstants.passwordPlaceholder, leadingAssistiveLabel: SignUpConstants.passwordLeadingAssistiveLabel))
        
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
        
        emailTextField.keyboardType = .emailAddress
        
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
    }
    
    private func configureUI() {
        signUpButton.configureRoundButtonWithShadow()
        
        logoImageView.layer.cornerRadius = 8
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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

struct SignUpConstants {
    
    static let emailLabel = "Email address"
    static let emailPlaceholder = "example@mail.com"
    static let emailLeadingAssistiveLabel = "You will use your email address to log in."
    
    static let passwordLabel = "Password"
    static let passwordPlaceholder: String? = nil
    static let passwordLeadingAssistiveLabel = "Min six characters, one digit and one upper letter."
}
