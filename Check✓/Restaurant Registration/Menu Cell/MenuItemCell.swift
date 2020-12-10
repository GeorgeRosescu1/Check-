//
//  MenuItemCell.swift
//  Check✓
//
//  Created by George Rosescu on 10.12.2020.
//

import UIKit

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var ingrdiendsLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        productImage.layer.cornerRadius = 4
        productImage.layer.shadowOpacity = 0.5
    }
}
