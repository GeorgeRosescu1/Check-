//
//  ViewController.swift
//  Check✓
//
//  Created by George Rosescu on 04/11/2020.
//

import UIKit
import Firebase

class CheckerTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchCurrentChecker()
    }

    
    private func fetchCurrentChecker() {
        let currentUserEmail = Auth.auth().currentUser?.email
                
        FirebaseAPI.getCurrentCheckerWithEmail(currentUserEmail ?? "") { (userDataDictionary) in
            let checker = Checker()
            checker.mapCheckerFromDictionary(dict: userDataDictionary)
            
            Session.registeredUser = checker
            
            return
        }
    }
}
