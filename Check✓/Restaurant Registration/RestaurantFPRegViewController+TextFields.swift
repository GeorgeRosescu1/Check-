//
//  RestaurantFPRegViewController+TextFields.swift
//  Check✓
//
//  Created by George Rosescu on 16.11.2020.
//

import Foundation
import UIKit

extension RestaurantFPRegViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case restaurantNameTextField:
            restaurantAddressTextField.becomeFirstResponder()
        case restaurantAddressTextField:
            restaurantAddressTextField.resignFirstResponder()
        default:
            
            return true
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case restaurantNameTextField:
            restaurantAddressTextField.becomeFirstResponder()
            restaurantToRegister.name = textField.text
        case restaurantAddressTextField:
            restaurantAddressTextField.resignFirstResponder()
            restaurantToRegister.address = textField.text
        default:
            
            return
        }
        
        validateFormData()
    }
}
