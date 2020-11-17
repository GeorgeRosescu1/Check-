//
//  RestaurantSPRegViewController.swift
//  Check✓
//
//  Created by George Rosescu on 16.11.2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextArea

class RestaurantSPRegViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionTextArea: MDCOutlinedTextArea!
    
    var restaurantToRegister = Restaurant()
    
    //MARK: Visibility controller
    var restaurantRegistrationSPageVC: TTInputVisibilityController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantRegistrationSPageVC = self.view.addInputVisibilityController()
        restaurantRegistrationSPageVC.extraSpaceAboveKeyboard = 10
        
//        nextButton.isUserInteractionEnabled = false
//        nextButton.alpha = 0.7
        
        pageControl.currentPage = 1
        
        descriptionTextArea.textView.delegate = self
        
        configureUI()
    }
    
    private func configureUI() {
        pageControl.currentPage = 1
        
        nextButton.configureRoundButtonWithShadow()
        
        profilePicture.layer.cornerRadius = 10
        profilePicture.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        profilePicture.layer.shadowOpacity = 0.5
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = #colorLiteral(red: 0.05882352941, green: 0.1882352941, blue: 0.3411764706, alpha: 1)
        
        self.view.addSubview(descriptionTextArea.configureAuthenticationTextField(labelText: RestaurantRegisterFormConstants.restaurantDescription, placeholderText: RestaurantRegisterFormConstants.restaurantDescriptionPlaceholder, leadingAssistiveLabel: nil))
        
        descriptionTextArea.sizeToFit()
    }
    
    @IBAction func nextPageAction(_ sender: UIButton) {
        descriptionTextArea.endEditing(true)
        
        restaurantToRegister.profilePicture = profilePicture.image
        
        guard let thirdPageForm = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "RestaurantTPRegViewController") as? RestaurantTPRegViewController else { return }
        
        thirdPageForm.restaurantToRegister = self.restaurantToRegister
        
        navigationController?.pushViewController(thirdPageForm, animated: false)
    }
    
    @objc func toolbarDoneAction(_ sender: UITextField) {
        restaurantToRegister.description = descriptionTextArea.description
        descriptionTextArea.resignFirstResponder()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func restaurantPictureAction(_ sender: UIControl) {
        handleImagePicking()
    }
}
