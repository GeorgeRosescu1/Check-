//
//  Checker.swift
//  Check✓
//
//  Created by George Rosescu on 07/11/2020.
//

import Foundation
import UIKit

class Checker: UserEntity {
    
    var uid: String?
    var age: Int!
    var firstName: String!
    var lastName: String!
    var email: String!
    var phoneNumber: String!
    var profilePictureURL: String?
    var profilePicture: UIImage?
    var pastRezervations: [Rezervation]?
    var futureRezervations: [Rezervation]?
    var ongoingRezervation: Rezervation?
    
    init() {
    }
    
    init(age: Int, firstName: String, lastName: String, email: String, phoneNumber: String, profilePicture: String) {
        self.age = age
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.profilePictureURL = profilePicture
    }
    
    
    func mapCheckerFromDictionary(dict: [String: Any]?) {
        self.firstName = dict?[CheckerConstants.FStore.firstName] as? String
        self.lastName = dict?[CheckerConstants.FStore.lastName] as? String
        self.age = dict?[CheckerConstants.FStore.age] as? Int
        self.phoneNumber = dict?[CheckerConstants.FStore.phoneNumber] as? String
        self.email = dict?[CheckerConstants.FStore.email] as? String
        self.profilePictureURL = dict?[CheckerConstants.FStore.profilePictureURL] as? String
    }
}

struct CheckerConstants {
    
    struct FStore {
        static let collectionName = "checkers"
        static let picturesCollectionName = "checkers profile pictures"
        
        static let uid = "uid"
        static let age = "age"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let email = "email"
        static let phoneNumber = "phoneNumber"
        static let pastRezervations = "pastRezervations"
        static let futureRezervations = "futureRezervations"
        static let ongoingRezervation = "ongoingRezervation"
        static let profilePictureURL = "profilePictureURL"
    }
}
