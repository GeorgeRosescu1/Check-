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
    
    private init() {
    }
    
    static var registeredUser: UserEntity?
    
    static var isRegisterRestaurant: Bool? {
        set { UserDefaults.standard.setValue(newValue, forKey: SessionKeys.isRegisterRestaurant) }
        get { UserDefaults.standard.bool(forKey: SessionKeys.isRegisterRestaurant) }
    }
    
    static var isRegisterChecker: Bool? {
        set { UserDefaults.standard.setValue(newValue, forKey: SessionKeys.isRegisterChecker) }
        get { UserDefaults.standard.bool(forKey: SessionKeys.isRegisterChecker) }
    }

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
    static let isRegisterRestaurant = "registered_restaurant"
    static let isRegisterChecker = "registered_checker"
}
