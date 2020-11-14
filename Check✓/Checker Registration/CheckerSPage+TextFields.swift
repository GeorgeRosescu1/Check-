//
//  CheckerSPage+TextFields.swift
//  Check✓
//
//  Created by George Rosescu on 14.11.2020.
//

import Foundation
import UIKit

extension CheckerSecondPageRegistrationViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkerToRegister.age = Int(ageTextField.text!)
        ageTextField.resignFirstResponder()
        
        return true
    }
}
