//
//  RestaurantSPRegViewController+TextFields.swift
//  Check✓
//
//  Created by George Rosescu on 17.11.2020.
//

import Foundation
import UIKit

extension RestaurantSPRegViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        restaurantToRegister.description = textView.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case phone:
            phone.resignFirstResponder()
        default:
    
            return true
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case phone:
            phone.resignFirstResponder()
            restaurantToRegister.phoneNumber = textField.text
        default:
            
            return
        }
    }
}
