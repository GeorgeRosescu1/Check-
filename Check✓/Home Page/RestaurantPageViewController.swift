//
//  RestaurantPageViewController.swift
//  Check✓
//
//  Created by George Rosescu on 07.12.2020.
//

import Foundation
import UIKit

class RestaurantPageViewController: UIViewController {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var timeRangeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var seeMenuButton: UIButton!
    @IBOutlet weak var reserveButton: UIButton!
    
    var restaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        restaurantNameLabel.text = restaurant?.name
        restaurantImageView.image = restaurant?.profilePicture
        timeRangeLabel.text = "\(restaurant?.openingHour ?? "08:00") - \(restaurant?.closingHour ?? "22:00")"
        locationLabel.text = restaurant?.address
        descriptionTextView.text = restaurant?.description
        
        seeMenuButton.layer.cornerRadius = 4
        reserveButton.layer.cornerRadius = 4
        
        seeMenuButton.layer.shadowOpacity = 0.6
        seeMenuButton.layer.shadowOffset = CGSize(width: 1, height: 0.5)
        
        reserveButton.layer.shadowOffset = CGSize(width: 1, height: 0.5)
        reserveButton.layer.shadowOpacity = 0.6
    }
    
    @IBAction func seeMenuAction(_ sender: UIButton) {
        let menuVC = AppStoryboards.CheckerAppMainMenu.instance?.instantiateViewController(identifier: "MenuViewController") as? MenuViewController
        
        if let menuVC = menuVC {
            menuVC.menu = restaurant!.menu
            self.present(menuVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func makeCallAction(_ sender: UIButton) {
        guard let phone = restaurant?.phoneNumber else { return }
        let phoneNumberURL = URL(string: "tel://\(phone)")
        
        if let url = phoneNumberURL, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func makeRezervationAction(_ sender: UIButton) {
    
    }
}
