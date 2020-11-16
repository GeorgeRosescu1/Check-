//
//  ViewController.swift
//  Check✓
//
//  Created by George Rosescu on 04/11/2020.
//

import UIKit
import Firebase

class CheckerTabBarViewController: UITabBarController {
    
    @IBOutlet weak var checkerTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = false
        fetchCurrentChecker()
    }
    
    
    private func fetchCurrentChecker() {
        let currentUserEmail = Auth.auth().currentUser?.email
        
        FirebaseAPI.getCurrentCheckerWithEmail(currentUserEmail ?? "") { (userDataDictionary) in
            let checker = Checker()
            checker.mapCheckerFromDictionary(dict: userDataDictionary)
            
            let storage = Storage.storage().reference().child(CheckerConstants.FStore.picturesCollectionName + "/" + checker.profilePictureURL!)
            
            storage.getData(maxSize: 15 * 1024 * 1024) { (data, error) in
                self.view.isUserInteractionEnabled = true

                if let homeVC = self.selectedViewController as? CheckerHomePageViewController {
                    homeVC.spinner.stopAnimating()
                }
                
                if let error = error {
                    debugPrint("Error while loading the photo \(error.localizedDescription)")
                    return
                } else {
                    guard let data = data else { return }
                    checker.profilePicture = UIImage(data: data)
                    
                    Session.registeredUser = checker
                }
            }
            
            return
        }
    }
}
