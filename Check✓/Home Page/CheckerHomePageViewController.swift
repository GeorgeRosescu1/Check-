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
    
    var restaurants: [Restaurant] = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isUserInteractionEnabled = false
        spinner.startAnimating()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: "RestaurantCell")
        
        DispatchQueue.main.async {
            self.fetchRestaurants()
        }
    }
    
    private func fetchRestaurants() {        
        FirebaseAPI.getAllRestaurants { (allRestaurants) in
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
            self.spinner.stopAnimating()
            self.restaurants = allRestaurants
            
            self.tableview.reloadData()
        }
    }
}
