//
//  CheckerSecondPageRegistrationViewController.swift
//  Check✓
//
//  Created by George Rosescu on 12/11/2020.
//

import Foundation
import UIKit
import MaterialComponents.MDCOutlinedTextField

class CheckerSecondPageRegistrationViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var ageTextField: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        pageControl.currentPage = 1
        
        finishButton.configureRoundButtonWithShadow()
        
        profilePicture.layer.cornerRadius = 10
        profilePicture.layer.shadowOffset = CGSize(width: 1, height: 1)
        profilePicture.layer.shadowOpacity = 0.4
        
        self.view.addSubview(ageTextField.configureAuthenticationTextField(labelText: CheckerRegisterFormConstants.ageText, placeholderText: CheckerRegisterFormConstants.agePlaceholder, leadingAssistiveLabel: CheckerRegisterFormConstants.ageAssistiveLabel))
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func finishAction(_ sender: UIButton) {
        print("Finish!!!")
        
    }
    
    @IBAction func profilePictureAction(_ sender: UIControl) {
        print("Zi o poza bosule")
        handleImagePicking()
    }
}
