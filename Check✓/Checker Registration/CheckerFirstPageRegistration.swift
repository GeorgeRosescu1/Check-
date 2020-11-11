//
//  CheckerFirstPageRegistration.swift
//  Check✓
//
//  Created by George Rosescu on 11/11/2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField

class CheckerFirstPageRegistration: UIViewController {
    
    @IBOutlet weak var firstNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var lastNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var phoneTextField: MDCOutlinedTextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: Visibility controller
    var checkerRegistrationFPageVC: TTInputVisibilityController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkerRegistrationFPageVC = self.view.addInputVisibilityController()
        checkerRegistrationFPageVC.extraSpaceAboveKeyboard = 10
        
        nextButton.configureRoundButtonWithShadow()
        nextButton.isUserInteractionEnabled = false
        nextButton.alpha = 0.7
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneTextField.delegate = self
        
        configureTextFields()
    }
    
    @IBAction func nextPageAction(_ sender: Any) {
        
    }
    
    private func configureTextFields() {
        
        self.view.addSubview(firstNameTextField.configureAuthenticationTextField(labelText: CheckerRegisterFormConstants.firstName, placeholderText: CheckerRegisterFormConstants.firstNamePlaceholder, leadingAssistiveLabel: nil))
        
        self.view.addSubview(lastNameTextField.configureAuthenticationTextField(labelText: CheckerRegisterFormConstants.lastName, placeholderText: CheckerRegisterFormConstants.lastNamePlaceholder, leadingAssistiveLabel: nil))
        
        self.view.addSubview(phoneTextField.configureAuthenticationTextField(labelText: CheckerRegisterFormConstants.phoneNumber, placeholderText: CheckerRegisterFormConstants.phonePlaceholder, leadingAssistiveLabel: nil))
        
        phoneTextField.keyboardType = .phonePad
        
    }
}

struct CheckerRegisterFormConstants {
    
    static let firstName = "First Name"
    static let firstNamePlaceholder = "Your first name"
    
    static let lastName = "Last Name"
    static let lastNamePlaceholder = "Your last name"
    
    static let phoneNumber = "Phone number"
    static let phonePlaceholder = "0799744071"
}
