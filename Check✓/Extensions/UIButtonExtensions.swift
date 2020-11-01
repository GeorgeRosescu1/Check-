//
//  UIButtonExtensions.swift
//  Check✓
//
//  Created by George Rosescu on 01/11/2020.
//

import Foundation
import UIKit

extension UIButton {
    
    func configureRoundButtonWithShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 16
    }
}
