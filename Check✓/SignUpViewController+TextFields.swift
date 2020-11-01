//
//  SignUpViewController+TextFields.swift
//  Check✓
//
//  Created by George Rosescu on 01/11/2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField

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
        if let textField = textField as? MDCOutlinedTextField {
            textField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.06004772335, green: 0.188975513, blue: 0.3412511945, alpha: 1), for: .normal)
        }
        
        switch textField {
        case emailTextField:
            signUpVC.toBeVisibleView = emailTextField
            emailTextField.leadingAssistiveLabel.text = SignUpConstants.emailLeadingAssistiveLabel
        case passwordTextField:
            signUpVC.toBeVisibleView = passwordTextField
            passwordTextField.leadingAssistiveLabel.text = SignUpConstants.passwordLeadingAssistiveLabel
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
    
    
    func validateEmail() -> Bool {
        //regex
        guard let emailText = emailText else {
            
            return false
        }
        
        if emailText.isEmpty {
            emailTextField.leadingAssistiveLabel.text = "Email address is mandatory."
            emailTextField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.8821824193, green: 0.3163513541, blue: 0.4430304468, alpha: 1), for: .normal)
            
            return false
        } else {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            
            if !emailPred.evaluate(with: emailText){
                emailTextField.leadingAssistiveLabel.text = "Please enter a valid email."
                emailTextField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.8821824193, green: 0.3163513541, blue: 0.4430304468, alpha: 1), for: .normal)
                
                return false
            }
            
            return true
        }
    }
    
    func validatePassword() -> Bool {
        guard let passwordText = passwordText else {
            
            return false
        }
        
        if passwordText.count < 6 {
            passwordTextField.leadingAssistiveLabel.text = "Password should be at least 6 chars long."
            passwordTextField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.8821824193, green: 0.3163513541, blue: 0.4430304468, alpha: 1), for: .normal)
            
            return false
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
                
                return false
            }
            
            if !validation2 {
                passwordTextField.leadingAssistiveLabel.text = "Password should contain digit."
                passwordTextField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.8821824193, green: 0.3163513541, blue: 0.4430304468, alpha: 1), for: .normal)
                
                return false
            }
        }
        
        return true
    }
}
