//
//  CheckerHomePageViewController.swift
//  Check✓
//
//  Created by George Rosescu on 01/11/2020.
//

import Foundation
import UIKit
import Firebase

class CheckerHomePageViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isUserInteractionEnabled = false
        spinner.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
            self.spinner.stopAnimating()
        }
    }
}
