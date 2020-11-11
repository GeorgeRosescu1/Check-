//
//  CheckerFPage+TextFields.swift
//  Check✓
//
//  Created by George Rosescu on 11/11/2020.
//

import Foundation
import UIKit

extension CheckerFirstPageRegistration: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            phoneTextField.becomeFirstResponder()
        case phoneTextField:
            phoneTextField.resignFirstResponder()
        default:
            return true
        }
        
        return true
    }
}
