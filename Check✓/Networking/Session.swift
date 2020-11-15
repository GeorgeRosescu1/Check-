//
//  Session.swift
//  Check✓
//
//  Created by George Rosescu on 03/11/2020.
//

import Foundation
import UIKit
import Firebase

struct Session {
    
    static var registeredUser: UserEntity?

    static var userToken: String? {
        set { UserDefaults.standard.setValue(newValue, forKey: SessionKeys.currentUser) }
        get { UserDefaults.standard.string(forKey: SessionKeys.currentUser) }
    }
    
    static var passedFirstTimeOnboarding: Bool {
        set { UserDefaults.standard.set(newValue, forKey: SessionKeys.firstTimeOnboarding) }
        get { UserDefaults.standard.bool(forKey: SessionKeys.firstTimeOnboarding)}
    }
}

struct SessionKeys {
    static let currentUser = "current_user"
    static let firstTimeOnboarding = "onboarding"
}
