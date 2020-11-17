//
//  MDCOutlinedTextFieldExtensions.swift
//  Check✓
//
//  Created by George Rosescu on 28/10/2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField

extension MDCOutlinedTextField {
    
    func configureAuthenticationTextField(labelText: String, placeholderText: String?, leadingAssistiveLabel: String?) -> MDCOutlinedTextField {
        let darkColor = #colorLiteral(red: 0.1321717799, green: 0.2752143443, blue: 0.3859785795, alpha: 1)
        
        self.placeholder = placeholderText ?? ""
        self.leadingAssistiveLabel.text = leadingAssistiveLabel ?? ""
        
        self.label.text = labelText
        self.setFloatingLabelColor(darkColor, for: .editing)
        self.setFloatingLabelColor(darkColor, for: .normal)
        self.setNormalLabelColor(.gray, for: .normal)
        
        self.setLeadingAssistiveLabelColor(darkColor, for: .editing)
        self.setLeadingAssistiveLabelColor(darkColor, for: .normal)
        self.leadingAssistiveLabel.isHidden = true
       
        self.setOutlineColor(.gray, for: .normal)
        self.setOutlineColor(darkColor, for: .editing)
        self.setTextColor(darkColor, for: .normal)
        self.setTextColor(darkColor, for: .editing)
        self.sizeToFit()
        
        return self
    }
}

extension MDCOutlinedTextArea {
    
    func configureAuthenticationTextField(labelText: String, placeholderText: String?, leadingAssistiveLabel: String?) -> MDCOutlinedTextArea {
        let darkColor = #colorLiteral(red: 0.1321717799, green: 0.2752143443, blue: 0.3859785795, alpha: 1)
        
        self.leadingAssistiveLabel.text = leadingAssistiveLabel ?? ""
        
        self.label.text = labelText
        self.setFloatingLabel(darkColor, for: .editing)
        
        self.leadingAssistiveLabel.isHidden = true
       
        self.setOutlineColor(.gray, for: .normal)
        self.setOutlineColor(darkColor, for: .editing)
        self.setTextColor(darkColor, for: .normal)
        self.setTextColor(darkColor, for: .editing)
        self.sizeToFit()
        
        return self
    }
}

