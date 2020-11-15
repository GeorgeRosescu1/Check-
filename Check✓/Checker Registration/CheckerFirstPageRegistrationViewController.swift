//
//  CheckerFirstPageRegistration.swift
//  Check✓
//
//  Created by George Rosescu on 11/11/2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField

class CheckerFirstPageRegistrationViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var lastNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var phoneTextField: MDCOutlinedTextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: Visibility controller
    var checkerRegistrationFPageVC: TTInputVisibilityController!
    
    var checkerToRegister = Checker()
    
    let phoneToolbar = UIToolbar()
    let toolbarDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(toolbarDoneAction(_:)))
    
    var formIsCompleted: Bool = false
    
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
        firstNameTextField.endEditing(true)
        lastNameTextField.endEditing(true)
        phoneTextField.endEditing(true)
        
        guard let secondPageForm = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "CheckerSecondPageRegistrationViewController") as? CheckerSecondPageRegistrationViewController else { return }
        
        secondPageForm.checkerToRegister = self.checkerToRegister
        
        navigationController?.pushViewController(secondPageForm, animated: false)
    }
    
    private func configureTextFields() {
        
        self.view.addSubview(firstNameTextField.configureAuthenticationTextField(labelText: CheckerRegisterFormConstants.firstName, placeholderText: CheckerRegisterFormConstants.firstNamePlaceholder, leadingAssistiveLabel: nil))
        
        self.view.addSubview(lastNameTextField.configureAuthenticationTextField(labelText: CheckerRegisterFormConstants.lastName, placeholderText: CheckerRegisterFormConstants.lastNamePlaceholder, leadingAssistiveLabel: nil))
        
        self.view.addSubview(phoneTextField.configureAuthenticationTextField(labelText: CheckerRegisterFormConstants.phoneNumber, placeholderText: CheckerRegisterFormConstants.phonePlaceholder, leadingAssistiveLabel: nil))
        
        phoneToolbar.items = [toolbarDoneButton]
        phoneToolbar.sizeToFit()
        phoneToolbar.isTranslucent = true
        
        phoneTextField.inputAccessoryView = phoneToolbar
        phoneTextField.keyboardType = .phonePad
        
        firstNameTextField.returnKeyType = .next
        lastNameTextField.returnKeyType = .next
    }
    
    @objc func toolbarDoneAction(_ sender: UITextField) {
        checkerToRegister.phoneNumber = phoneTextField.text
        phoneTextField.resignFirstResponder()
    }
    
    func validateFormData() {
        guard let firstNameText = firstNameTextField.text else { return  }
        guard let lastNameText = lastNameTextField.text else { return  }
        guard let phoneText = phoneTextField.text else { return  }
        
        if !firstNameText.isEmpty && !lastNameText.isEmpty && !phoneText.isEmpty {
            nextButton.isUserInteractionEnabled = true
            nextButton.alpha = 1
        } else {
            nextButton.isUserInteractionEnabled = false
            nextButton.alpha = 0.7
        }
    }
}

struct CheckerRegisterFormConstants {
    
    static let firstName = "First Name"
    static let firstNamePlaceholder = "Your first name"
    
    static let lastName = "Last Name"
    static let lastNamePlaceholder = "Your last name"
    
    static let phoneNumber = "Phone number"
    static let phonePlaceholder = "0799744071"
    
    static let ageText = "Age"
    static let agePlaceholder = "Your age"
    static let ageAssistiveLabel = "Age should be a number between 14 and 130"
}
