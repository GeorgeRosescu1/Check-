//
//  RestaurantFPRegViewController.swift
//  Check✓
//
//  Created by George Rosescu on 16.11.2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField

class RestaurantFPRegViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var restaurantNameTextField: MDCOutlinedTextField!
    @IBOutlet weak var restaurantAddressTextField: MDCOutlinedTextField!
    
    //MARK: Visibility controller
    var restaurantRegistrationFPageVC: TTInputVisibilityController!
    
    var restaurantToRegister = Restaurant()
    
    var formIsCompleted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantRegistrationFPageVC = self.view.addInputVisibilityController()
        restaurantRegistrationFPageVC.extraSpaceAboveKeyboard = 10
        
        nextButton.configureRoundButtonWithShadow()
//        nextButton.isUserInteractionEnabled = false
//        nextButton.alpha = 0.7
        
        restaurantNameTextField.delegate = self
        restaurantAddressTextField.delegate = self
        
        configureTextFields()
    }
    
    private func configureTextFields() {
        
        self.view.addSubview(restaurantNameTextField.configureAuthenticationTextField(labelText: RestaurantRegisterFormConstants.restaurantName, placeholderText: RestaurantRegisterFormConstants.frestaurantNamePlaceholder, leadingAssistiveLabel: nil))
        
        self.view.addSubview(restaurantAddressTextField.configureAuthenticationTextField(labelText: RestaurantRegisterFormConstants.restaurantAddress, placeholderText: RestaurantRegisterFormConstants.restaurantAddressPlaceholder, leadingAssistiveLabel: nil))
        
        restaurantNameTextField.returnKeyType = .next
        restaurantAddressTextField.returnKeyType = .done
        
        restaurantNameTextField.autocapitalizationType = .words
        restaurantAddressTextField.autocapitalizationType = .words
    }
    
    func validateFormData() {
        guard let restaurantNameText = restaurantNameTextField.text else { return  }
        guard let restaurantAddressText = restaurantAddressTextField.text else { return  }
        
        if !restaurantNameText.isEmpty && !restaurantAddressText.isEmpty {
            nextButton.isUserInteractionEnabled = true
            nextButton.alpha = 1
        } else {
            nextButton.isUserInteractionEnabled = false
            nextButton.alpha = 0.7
        }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        restaurantNameTextField.endEditing(true)
        restaurantAddressTextField.endEditing(true)
        
        guard let secondPageForm = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "RestaurantSPRegViewController") as? RestaurantSPRegViewController else { return }
        
        secondPageForm.restaurantToRegister = self.restaurantToRegister
        
        navigationController?.pushViewController(secondPageForm, animated: false)
    }
}

struct RestaurantRegisterFormConstants {
    
    static let restaurantName = "Restaurant Name"
    static let frestaurantNamePlaceholder = "Your restaurant name"
    
    static let restaurantAddress = "Restaurant Address"
    static let restaurantAddressPlaceholder = "Your restaurant address"
    
    static let restaurantDescription = "Restaurant description"
    static let restaurantDescriptionPlaceholder = "Tell us some words about your restaurant"
    
}
