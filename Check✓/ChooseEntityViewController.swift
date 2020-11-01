//
//  ChooseEntityViewController.swift
//  Check✓
//
//  Created by George Rosescu on 01/11/2020.
//

import Foundation
import UIKit

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
        guard let signUpVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController else { return }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func checkerAction(_ sender: UIButton) {
        guard let signUpVC = AppStoryboards.Authenthication.instance?.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController else { return }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
