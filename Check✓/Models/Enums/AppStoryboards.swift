//
//  AppStoryboards.swift
//  Check✓
//
//  Created by George Rosescu on 25/10/2020.
//

import Foundation
import UIKit

enum AppStoryboards: String {
    
    case Onboarding = "Main"
    case Authenthication = "Authentication"
    case MainPage = "MainPage"
    
    var instance: UIStoryboard? {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
