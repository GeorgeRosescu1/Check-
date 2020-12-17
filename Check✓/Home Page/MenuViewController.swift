//
//  MenuViewController.swift
//  Check✓
//
//  Created by George Rosescu on 12.12.2020.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menu = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
        tableView.register(UINib(nibName: "MenuItemCell", bundle: nil), forCellReuseIdentifier: "MenuItemCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as! MenuItemCell
        let product = menu[indexPath.row]
        
        cell.productNameLabel.text = product.name
        cell.productPriceLabel.text = product.price
        cell.ingrdiendsLabel.text = product.ingrediends
        cell.productImage.image = product.image
        cell.selectionStyle = .none
        return cell
    }
}
