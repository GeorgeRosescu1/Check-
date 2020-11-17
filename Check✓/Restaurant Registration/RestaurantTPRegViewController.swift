//
//  RestaurantTPRegViewController.swift
//  Check✓
//
//  Created by George Rosescu on 16.11.2020.
//

import Foundation
import UIKit
import Firebase

class RestaurantTPRegViewController: UIViewController{
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var restaurantToRegister = Restaurant()
    
    let firestore = Firestore.firestore()
    let storage = Storage.storage().reference().child(CheckerConstants.FStore.picturesCollectionName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 2
        
        finishButton.configureRoundButtonWithShadow()
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func finishAction(_ sender: UIButton) {
        spinner.startAnimating()
        
        guard let profilePictureData = restaurantToRegister.profilePicture?.jpegData(compressionQuality: 1) else { return }
        let imageName = UUID().uuidString
        
        let imageStorage = storage.child(imageName)
        
        imageStorage.putData(profilePictureData, metadata: nil) { (metadata, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            } else {
                let data: [String: Any] = [
                    RestaurantConstants.FStore.name: self.restaurantToRegister.name!,
                    RestaurantConstants.FStore.address: self.restaurantToRegister.address!,
                    RestaurantConstants.FStore.description: self.restaurantToRegister.description!,
                    RestaurantConstants.FStore.openingHour: "08:00", // change this
                    RestaurantConstants.FStore.closingHour: "22:00", // change this
                    RestaurantConstants.FStore.pictureURL: imageName
                ]
                
                
                self.firestore.collection(RestaurantConstants.FStore.collectionName).addDocument(data: data) { (error) in
                    self.spinner.stopAnimating()
                    if let error = error {
                        SwiftMessagesAlert.displaySmallErrorWithBody(error.localizedDescription)
                    } else {
                        SwiftMessagesAlert.displaySmallSuccessWithBody("Registration successful🤩")
                        guard let checkerMainMenu = AppStoryboards.RestaurantMainApp.instance?.instantiateViewController(identifier: "RestaurantTabBarViewController") as? RestaurantTabBarViewController else { return }
                        checkerMainMenu.tabBar.isUserInteractionEnabled = false
                        self.navigationController?.pushViewController(checkerMainMenu, animated: true)
                    }
                }
            }
        }
    }
    
}
