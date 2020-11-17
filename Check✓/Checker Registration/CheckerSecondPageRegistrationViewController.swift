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
    
    @IBOutlet weak var profilePictureControlView: UIControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var ageTextField: MDCOutlinedTextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var checkerToRegister = Checker()
    
    let firestore = Firestore.firestore()
    let storage = Storage.storage().reference().child(CheckerConstants.FStore.picturesCollectionName)
    
    let ageToolbar = UIToolbar()
    let toolbarDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(toolbarDoneAction(_:)))
    
    //MARK: Visibility controller
    var checkerRegistrationSPageVC: TTInputVisibilityController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkerRegistrationSPageVC = self.view.addInputVisibilityController()
        checkerRegistrationSPageVC.extraSpaceAboveKeyboard = 10
        
        ageTextField.delegate = self
        
        finishButton.isUserInteractionEnabled = false
        finishButton.alpha = 0.7
        
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
        
        ageToolbar.items = [toolbarDoneButton]
        ageToolbar.sizeToFit()
        ageToolbar.isTranslucent = true
        
        ageTextField.keyboardType = .numberPad
        ageTextField.inputAccessoryView = ageToolbar
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    func validateFormData() {
        guard let ageText = ageTextField.text else { return  }
        
        if !ageText.isEmpty {
            finishButton.isUserInteractionEnabled = true
            finishButton.alpha = 1
        } else {
            finishButton.isUserInteractionEnabled = false
            finishButton.alpha = 0.7
        }
    }
    
    @objc func toolbarDoneAction(_ sender: UITextField) {
        checkerToRegister.age = Int(ageTextField.text!)
        ageTextField.resignFirstResponder()
    }
    
    @IBAction func finishAction(_ sender: UIButton) {
        ageTextField.endEditing(true)
        
        spinner.startAnimating()
        
        guard let profilePictureData = profilePicture.image?.jpegData(compressionQuality: 1) else { return }
        let imageName = UUID().uuidString
        
        let imageStorage = storage.child(imageName)
        
        self.backButton.isUserInteractionEnabled = false
        self.ageTextField.isUserInteractionEnabled = false
        self.profilePictureControlView.isUserInteractionEnabled = false
        
        imageStorage.putData(profilePictureData, metadata: nil) { (metadata, error) in
            if let error = error {
                self.backButton.isUserInteractionEnabled = true
                self.ageTextField.isUserInteractionEnabled = true
                self.profilePictureControlView.isUserInteractionEnabled = true
                
                debugPrint(error.localizedDescription)
                
                return
            } else {
                let data: [String: Any] = [
                    CheckerConstants.FStore.age: self.checkerToRegister.age!,
                    CheckerConstants.FStore.firstName: self.checkerToRegister.firstName!,
                    CheckerConstants.FStore.lastName: self.checkerToRegister.lastName!,
                    CheckerConstants.FStore.phoneNumber: self.checkerToRegister.phoneNumber!,
                    CheckerConstants.FStore.email: self.checkerToRegister.email!,
                    CheckerConstants.FStore.profilePictureURL: imageName
                ]
                
                
                self.firestore.collection(CheckerConstants.FStore.collectionName).addDocument(data: data) { (error) in
                    self.spinner.stopAnimating()
                    if let error = error {
                        SwiftMessagesAlert.displaySmallErrorWithBody(error.localizedDescription)
                    } else {
                        SwiftMessagesAlert.displaySmallSuccessWithBody("Registration successful🤩")
                        guard let checkerMainMenu = AppStoryboards.CheckerAppMainMenu.instance?.instantiateViewController(identifier: "CheckerTabBarViewController") as? CheckerTabBarViewController else { return }
                        checkerMainMenu.tabBar.isUserInteractionEnabled = false
                        self.navigationController?.pushViewController(checkerMainMenu, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func profilePictureAction(_ sender: UIControl) {
        handleImagePicking()
    }
}
