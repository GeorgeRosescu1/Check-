//
//  ViewController.swift
//  Check✓
//
//  Created by George Rosescu on 20/10/2020.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboardingImage: UIImageView!
    @IBOutlet weak var onboardingDescriptionLabel: UILabel!
    @IBOutlet weak var onboardingTitleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var onboardingVM = OnboardingViewModel()
    var currentScreen: OnboardingScreen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 4
        
        nextButton.layer.cornerRadius = 8
        nextButton.layer.shadowOpacity = 0.2
        nextButton.layer.shadowRadius = 16
        
        updateContent()
    }
    
    @IBAction func nextPageAction(_ sender: UIButton) {
        if pageControl.currentPage == onboardingVM.onboardingScreens.count - 1 {
            guard let loginVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
            self.navigationController?.pushViewController(loginVC, animated: true)
        } else {
            onboardingVM.nextPage()
            updateContent()
            pageControl.currentPage += 1
            
            if pageControl.currentPage == onboardingVM.onboardingScreens.count - 1 {
                skipButton.isHidden = true
                nextButton.setTitle("Finish", for: .normal)
                nextButton.frame = CGRect(x: nextButton.frame.minX - 20, y: nextButton.frame.minY, width: nextButton.frame.width + 40, height: nextButton.frame.height)
                nextButton.setImage(nil, for: .normal)
                nextButton.layer.cornerRadius = nextButton.frame.height / 2
            }
        }
    }
    
    @IBAction func skipAction(_ sender: UIButton) {
        guard let loginVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func updateContent() {
        currentScreen = onboardingVM.getCurrentPageContent()
        
        onboardingImage.image = currentScreen?.image
        onboardingTitleLabel.text = currentScreen?.title
        onboardingDescriptionLabel.text = currentScreen?.description
    }
}

