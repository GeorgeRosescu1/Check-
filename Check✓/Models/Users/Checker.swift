//
//  Checker.swift
//  Check✓
//
//  Created by George Rosescu on 07/11/2020.
//

import Foundation
import UIKit

class Checker {
    
    var age: Int!
    var firstName: String!
    var lastName: String!
    var email: String!
    var phoneNumber: String!
    var profilePicture: UIImage?
    var pastRezervations: [Rezervation]?
    var futureRezervations: [Rezervation]?
    var ongoingRezervation: Rezervation?
    
    init() {
    }
    
    init(age: Int, firstName: String, lastName: String, email: String, phoneNumber: String, profilePicture: UIImage) {
        self.age = age
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.profilePicture = profilePicture
    }
}

struct CheckerConstants {
    
    struct FStore {
        static let collectionName = "checkers"
        
        static let age = "age"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let email = "email"
        static let phoneNumber = "phoneNumber"
        static let pastRezervations = "pastRezervations"
        static let futureRezervations = "futureRezervations"
        static let ongoingRezervation = "ongoingRezervation"
        static let profilePicture = "profilePicture"
    }
}
