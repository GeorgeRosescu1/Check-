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
            openHourTextField.becomeFirstResponder()
        case openHourTextField:
            closingHourTextField.becomeFirstResponder()
        case closingHourTextField:
            closingHourTextField.resignFirstResponder()
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
            openHourTextField.resignFirstResponder()
            restaurantToRegister.address = textField.text
        case openHourTextField:
            closingHourTextField.becomeFirstResponder()
            restaurantToRegister.openingHour = textField.text
        case closingHourTextField:
            closingHourTextField.resignFirstResponder()
            restaurantToRegister.closingHour = textField.text
        default:
            
            return
        }
        
        validateFormData()
    }
}
