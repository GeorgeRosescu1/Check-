//
//  RestaurantTabBarViewController.swift
//  Check✓
//
//  Created by George Rosescu on 17.11.2020.
//

import Foundation
import UIKit
import Firebase

class RestaurantTabBarViewController: UITabBarController {
    
    let restaurnat = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = false
        fetchCurrentRestaurant()
    }
    
    
    private func fetchCurrentRestaurant() {
        let currentUserEmail = Auth.auth().currentUser?.email
        
        FirebaseAPI.getCurrentRestaurantWithEmail(currentUserEmail ?? "") { (userDataDictionary) in
            let restaurant = Restaurant()
            restaurant.mapRestaurantFromDictionary(dict: userDataDictionary)
            
            self.view.isUserInteractionEnabled = true
            
            
            let storage = Storage.storage().reference().child(RestaurantConstants.FStore.picturesCollectionName + "/" + restaurant.pictureURL!)
            
            storage.getData(maxSize: 15 * 1024 * 1024) { (data, error) in
                self.view.isUserInteractionEnabled = true
                
                if let homeVC = self.selectedViewController as? RestaurantRezervationsViewController {
                    homeVC.spinner.stopAnimating()
                }
                
                if let error = error {
                    debugPrint("Error while loading the photo \(error.localizedDescription)")
                    return
                } else {
                    guard let data = data else { return }
                    restaurant.profilePicture = UIImage(data: data)
                    
                    Session.registeredUser = restaurant
                }
            }
            
            return
        }
    }
}
