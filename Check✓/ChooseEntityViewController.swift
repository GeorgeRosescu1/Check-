//
//  ChooseEntityViewController.swift
//  Check✓
//
//  Created by George Rosescu on 01/11/2020.
//

import Foundation
import UIKit
import Firebase

class ChooseEntityViewController: UIViewController {
    
    @IBOutlet weak var checkPlaceButton: UIButton!
    @IBOutlet weak var checkerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        checkPlaceButton.configureRoundButtonWithShadow()
        checkerButton.configureRoundButtonWithShadow()
    }
    
    @IBAction func checkPlaceAction(_ sender: UIButton) {
        guard let loginVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        loginVC.isUserChecker = false
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func checkerAction(_ sender: UIButton) {
        guard let loginVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        loginVC.isUserChecker = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

}
