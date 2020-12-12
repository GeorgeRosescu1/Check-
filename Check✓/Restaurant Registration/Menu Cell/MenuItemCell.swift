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
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.shadowOpacity = 0.6
        cellView.layer.shadowOffset = CGSize(width: 0.5, height: 1)
    }
}
