//
//  RegisterViewController.swift
//  Check✓
//
//  Created by George Rosescu on 25/10/2020.
//

import UIKit
import MaterialComponents.MaterialTextFields
import RAGTextField

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordMaterialTextField: RAGTextField!
    @IBOutlet weak var emailMaterialTextField: RAGTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordMaterialTextField.delegate = self
        emailMaterialTextField.delegate = self
        
        configureUI()
        
    }

    @IBAction func signUpAction(_ sender: UIButton) {
        print("Sign up")
    }
    
    private func configureUI() {
        signUpButton.layer.cornerRadius = 8
        signUpButton.layer.shadowOpacity = 0.2
        signUpButton.layer.shadowRadius = 16
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.8
        
        passwordMaterialTextField.placeholderColor = .white
        passwordMaterialTextField.textPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        passwordMaterialTextField.borderStyle = .roundedRect
        passwordMaterialTextField.textColor = .white
       // passwordMaterialTextField.
        
        emailMaterialTextField.textColor = .white
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailMaterialTextField {
            passwordMaterialTextField.becomeFirstResponder()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
