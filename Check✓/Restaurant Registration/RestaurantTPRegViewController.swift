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
    @IBOutlet weak var noItemsImageView: UIImageView!
    @IBOutlet weak var noItemsLabel: UILabel!
    @IBOutlet weak var itemsTableView: UITableView!
    
    var restaurantToRegister = Restaurant()
    
    let firestore = Firestore.firestore()
    let storage = Storage.storage().reference().child(RestaurantConstants.FStore.picturesCollectionName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 2
        
        itemsTableView.delegate = self
        itemsTableView.register(UINib(nibName: "MenuItemCell", bundle: nil), forCellReuseIdentifier: "MenuItemCell")
        
        finishButton.configureRoundButtonWithShadow()
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func addItemAction(_ sender: UIButton) {
        let productAlert = UIAlertController(title: "Menu product", message: "Add a new product to menu", preferredStyle: .alert)
        
        self.present(productAlert, animated: true, completion: nil)
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
                    RestaurantConstants.FStore.uid: self.restaurantToRegister.uid!,
                    RestaurantConstants.FStore.name: self.restaurantToRegister.name!,
                    RestaurantConstants.FStore.address: self.restaurantToRegister.address!,
                    RestaurantConstants.FStore.description: self.restaurantToRegister.description!,
                    RestaurantConstants.FStore.email: self.restaurantToRegister.email!,
                    RestaurantConstants.FStore.openingHour: self.restaurantToRegister.openingHour!,
                    RestaurantConstants.FStore.closingHour: self.restaurantToRegister.closingHour!,
                    RestaurantConstants.FStore.phoneNumber: self.restaurantToRegister.phoneNumber!,
                    RestaurantConstants.FStore.pictureURL: imageName
                ]
                
                
                self.firestore.collection(RestaurantConstants.FStore.collectionName).addDocument(data: data) { (error) in
                    self.spinner.stopAnimating()
                    if let error = error {
                        SwiftMessagesAlert.displaySmallErrorWithBody(error.localizedDescription)
                    } else {
                        Session.isRegisterRestaurant = true
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
