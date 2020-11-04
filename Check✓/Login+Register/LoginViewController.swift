//
//  LoginViewController.swift
//  Check✓
//
//  Created by George Rosescu on 25/10/2020.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let emailToolbar = UIToolbar()
    let passwordToolbar = UIToolbar()
    let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(toolbarNextAction(_:)))
    let showPassword = UIBarButtonItem(title: "Show password", style: .plain, target: self, action: #selector(showPassword(_:)))
    
    var isToolbarShowButtonVisible = true
    
    //MARK: Visibility controller
    var loginVC: TTInputVisibilityController!
    
    var emailText = ""
    var passwordText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginVC = self.view.addInputVisibilityController()
        loginVC.extraSpaceAboveKeyboard = 10
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        configureUI()
        configureTextFields()
    }
    
    private func configureUI() {
        loginButton.configureRoundButtonWithShadow()
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
    
    //session
    @IBAction func loginAction(_ sender: UIButton) {
        loginButton.isUserInteractionEnabled = false
        loginButton.alpha = 0.7
        spinner.startAnimating()
        FirebaseAuth.loginUserWithEmail(emailText, password: passwordText) { (loginModel) in
            self.loginButton.isUserInteractionEnabled = true
            self.loginButton.alpha = 1
            self.spinner.stopAnimating()
            if loginModel.error != nil {
                SwiftMessagesAlert.displaySmallErrorWithBody("User not found or user may have been deleted.")
            } else {
                guard let mainVc = AppStoryboards.CheckerAppMainMenu.instance?.instantiateViewController(identifier: "TabBarViewController") as? CheckerTabBarViewController else { return }
                self.navigationController?.pushViewController(mainVc, animated: true)
            }
        }
        
    }
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        print("forgot pass :(")
    }
    
    @IBAction func goToRegister(_ sender: UIButton) {
        guard let chooseEntittVc = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "ChooseEntityViewController") as? ChooseEntityViewController else { return }
        self.navigationController?.pushViewController(chooseEntittVc, animated: true)
    }
}
