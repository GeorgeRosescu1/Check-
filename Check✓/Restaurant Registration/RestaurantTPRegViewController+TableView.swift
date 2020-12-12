//
//  RestaurantTPRegViewController+TableView.swift
//  Check✓
//
//  Created by George Rosescu on 10.12.2020.
//

import Foundation
import UIKit

extension RestaurantTPRegViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as! MenuItemCell
        let product = products[indexPath.row]
        
        cell.productNameLabel.text = product.name
        cell.productPriceLabel.text = product.price
        cell.ingrdiendsLabel.text = product.ingrediends
        cell.productImage.image = product.image
        cell.selectionStyle = .none
        return cell
    }
}
