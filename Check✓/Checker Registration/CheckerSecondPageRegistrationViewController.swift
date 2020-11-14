//
//  CheckerSecondPageRegistrationViewController.swift
//  Check✓
//
//  Created by George Rosescu on 12/11/2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField
import Firebase

class CheckerSecondPageRegistrationViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var ageTextField: MDCOutlinedTextField!
    
    var checkerToRegister = Checker()
    
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageTextField.delegate = self
        
        configureUI()
    }
    
    private func configureUI() {
        pageControl.currentPage = 1
        
        finishButton.configureRoundButtonWithShadow()
        
        profilePicture.layer.cornerRadius = 10
        profilePicture.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        profilePicture.layer.shadowOpacity = 0.5
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = #colorLiteral(red: 0.05882352941, green: 0.1882352941, blue: 0.3411764706, alpha: 1)
        
        self.view.addSubview(ageTextField.configureAuthenticationTextField(labelText: CheckerRegisterFormConstants.ageText, placeholderText: CheckerRegisterFormConstants.agePlaceholder, leadingAssistiveLabel: CheckerRegisterFormConstants.ageAssistiveLabel))
        
        //drop down maybe
        ageTextField.keyboardType = .numbersAndPunctuation
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func finishAction(_ sender: UIButton) {
        //TODO fix optionals
        let data: [String: Any] = [
            CheckerConstants.FStore.age: checkerToRegister.age!,
            CheckerConstants.FStore.firstName: checkerToRegister.firstName!,
            CheckerConstants.FStore.lastName: checkerToRegister.lastName!,
            CheckerConstants.FStore.phoneNumber: checkerToRegister.phoneNumber!,
            CheckerConstants.FStore.email: checkerToRegister.email!,
            CheckerConstants.FStore.profilePicture: ""
        ]
        
        
        firestore.collection(CheckerConstants.FStore.collectionName).addDocument(data: data) { (error) in
            if let error = error {
                SwiftMessagesAlert.displaySmallErrorWithBody(error.localizedDescription)
            } else {
                SwiftMessagesAlert.displaySmallSuccessWithBody("Registration successful🤩")
                guard let checkerMainMenu = AppStoryboards.CheckerAppMainMenu.instance?.instantiateViewController(identifier: "CheckerTabBarViewController") else { return }
                self.navigationController?.pushViewController(checkerMainMenu, animated: true)
            }
        }
    }
    
    @IBAction func profilePictureAction(_ sender: UIControl) {
        handleImagePicking()
    }
}
