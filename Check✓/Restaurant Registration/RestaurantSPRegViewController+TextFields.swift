//
//  RestaurantSPRegViewController+TextFields.swift
//  Check✓
//
//  Created by George Rosescu on 17.11.2020.
//

import Foundation
import UIKit

extension RestaurantSPRegViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        restaurantToRegister.description = textView.text
    }
}
