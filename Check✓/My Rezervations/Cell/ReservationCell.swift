//
//  ReservationCell.swift
//  Check✓
//
//  Created by George Rosescu on 22.12.2020.
//

import UIKit

class ReservationCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var reservationText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.shadowOpacity = 0.3
    }
    
}
