//
//  Restaurant.swift
//  Check✓
//
//  Created by George Rosescu on 07/11/2020.
//

import Foundation
import UIKit

class Restaurant: UserEntity {
    
    var name: String!
    var address: String!
    var phoneNumber: String!
    var email: String!
    var openingHour: Date!
    var closingHour: Date!
    var menu: [Product]?
    var description: String!
    var pictureURL: String!
    var profilePicture: UIImage?
    var starRatings: [Double]! // star rating will be mandatory after each rezervation is done
    var writtenReviews: [String]! // not mandatory
    var tables: [String]! // table type
    
    var averageRatingInStars: Double { // this will be dispayed for each restaurant only when starRatings.count > 2
        let starRatingsSum = starRatings.reduce(0) { $0 + $1 }
        
        return starRatingsSum / Double(starRatings.count)
    }
    
    var popularity: Double { // not displayed but a search and display order criteria
        let firstCriteria = 0.4 * Double(starRatings.count)
        let secondCriteria = 0.3 * averageRatingInStars
        let thirdCriteria = 0.1 * Double(writtenReviews.count)
        
        return firstCriteria + secondCriteria + thirdCriteria
    }
    
     func mapRestaurantFromDictionary(dict: [String: Any]?) {
        self.name = dict?[RestaurantConstants.FStore.name] as? String
        self.address = dict?[RestaurantConstants.FStore.address] as? String
        self.description = dict?[RestaurantConstants.FStore.description] as? String
       // self.phoneNumber = dict?[RestaurantConstants.FStore.phoneNumber] as? String
      //  self.email = dict?[RestaurantConstants.FStore.email] as? String
        self.pictureURL = dict?[RestaurantConstants.FStore.pictureURL] as? String
    }
}

struct RestaurantConstants {
    
    struct FStore {
        static let collectionName = "restaurants"
        static let picturesCollectionName = "restaurants profile pictures"
        
        static let name = "name"
        static let address = "address"
        static let phoneNumber = "phoneNumber"
        static let email = "email"
        static let openingHour = "openingHour"
        static let closingHour = "closingHour"
        static let description = "description"
        static let pictureURL = "pictureURL"
    }
}
