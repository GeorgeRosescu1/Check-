//
//  ViewController.swift
//  Check✓
//
//  Created by George Rosescu on 20/10/2020.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var onBoardingImage: UIImageView!
    @IBOutlet weak var onBoardingDescriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onBoardingImage.image = #imageLiteral(resourceName: "restaurants")
        pageTitleLabel.text = "Descopera"
        onBoardingDescriptionLabel.text = "Descopera rapid toate restaurantele din jurul tau in functie de criteriile dorite"
        nextButton.layer.cornerRadius = 12
    }

    @IBAction func nextPageAction(_ sender: UIButton) {
        
    }
    
    @IBAction func skipAction(_ sender: UIButton) {
        
    }
}

