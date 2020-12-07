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
            openHour.becomeFirstResponder()
        case openHour:
            closingHour.becomeFirstResponder()
        case closingHour:
            closingHour.resignFirstResponder()
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
            openHour.resignFirstResponder()
            restaurantToRegister.address = textField.text
        case openHour:
            closingHour.becomeFirstResponder()
            restaurantToRegister.openingHour = textField.text
        case closingHour:
            closingHour.resignFirstResponder()
            restaurantToRegister.closingHour = textField.text
        default:
            
            return
        }
        
        validateFormData()
    }
}
