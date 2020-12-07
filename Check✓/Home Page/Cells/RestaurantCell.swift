//
//  RestaurantCell.swift
//  Check✓
//
//  Created by George Rosescu on 05.12.2020.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    
    var restaurant: Restaurant!
    var cellNavigationAction: ((Restaurant) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cellView.layer.shadowOpacity = 0.6
        
        seeMoreButton.layer.cornerRadius = 4
    }
    
    @IBAction func seeMore(_ sender: UIButton) {
        cellNavigationAction(restaurant)
    }
}
