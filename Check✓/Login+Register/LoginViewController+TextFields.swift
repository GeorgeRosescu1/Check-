//
//  LoginViewController+TextFields.swift
//  Check✓
//
//  Created by George Rosescu on 01/11/2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField

extension LoginViewController: UITextFieldDelegate {
    
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let textField = textField as? MDCOutlinedTextField {
            textField.setLeadingAssistiveLabelColor(#colorLiteral(red: 0.06004772335, green: 0.188975513, blue: 0.3412511945, alpha: 1), for: .normal)
        }
        
        switch textField {
        case emailTextField:
            loginVC.toBeVisibleView = emailTextField
        case passwordTextField:
            loginVC.toBeVisibleView = passwordTextField
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

