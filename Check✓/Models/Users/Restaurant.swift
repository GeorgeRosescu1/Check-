//
//  Restaurant.swift
//  Check✓
//
//  Created by George Rosescu on 07/11/2020.
//

import Foundation
import UIKit

class Restaurant: UserEntity {
    
    var uid: String?
    var name: String!
    var address: String!
    var phoneNumber: String!
    var email: String!
    var openingHour: String!
    var closingHour: String!
    var menu: [Product]!
    var description: String!
    var pictureURL: String!
    var profilePicture: UIImage?
    var starRatings: [Double]! // star rating will be mandatory after each rezervation is done
    var writtenReviews: [String]! // not mandatory
    
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
        self.menu = [Product]()
        
        self.name = dict?[RestaurantConstants.FStore.name] as? String
        self.address = dict?[RestaurantConstants.FStore.address] as? String
        self.description = dict?[RestaurantConstants.FStore.description] as? String
        self.phoneNumber = dict?[RestaurantConstants.FStore.phoneNumber] as? String
        self.openingHour = dict?[RestaurantConstants.FStore.openingHour] as? String
        self.closingHour = dict?[RestaurantConstants.FStore.closingHour] as? String
        self.email = dict?[RestaurantConstants.FStore.email] as? String
        self.pictureURL = dict?[RestaurantConstants.FStore.pictureURL] as? String
        
        let productsDict = dict?[RestaurantConstants.FStore.menuProducts] as? [String: [String: Any]]
        if let dict = productsDict {
            for item in dict.values {
                let ingredients = item[ProductConstants.FStore.ingrediends] as! String
                let price = item[ProductConstants.FStore.price] as! String
                let name = item[ProductConstants.FStore.name] as! String
                
                var image = UIImage()
                
                if name.lowercased().contains("pizza") {
                    image = #imageLiteral(resourceName: "pizza")
                } else if name.lowercased().contains("sushi") {
                    image = #imageLiteral(resourceName: "sushi")
                } else if name.lowercased().contains("double") {
                    image = #imageLiteral(resourceName: "doubleBurger")
                } else if name.lowercased().contains("tacos") {
                    image = #imageLiteral(resourceName: "tacos")
                } else if name.lowercased().contains("bolognese") {
                    image = #imageLiteral(resourceName: "pastaBolognese")
                } else if name.lowercased().contains("home") || name.lowercased().contains("burger") {
                    image = #imageLiteral(resourceName: "homeBurger")
                } else if name.lowercased().contains("carbonara") {
                    image = #imageLiteral(resourceName: "pastaCarbonara")
                } else {
                    image = #imageLiteral(resourceName: "savureaza")
                }
                
                let product = Product(price: price, name: name, ingrediends: ingredients, image: image)
                
                self.menu.append(product)
            }
        }
    }
}

struct RestaurantConstants {
    
    struct FStore {
        static let collectionName = "restaurants"
        static let picturesCollectionName = "restaurants profile pictures"
        
        static let uid = "uid"
        static let name = "name"
        static let address = "address"
        static let phoneNumber = "phoneNumber"
        static let email = "email"
        static let openingHour = "openingHour"
        static let closingHour = "closingHour"
        static let description = "description"
        static let pictureURL = "pictureURL"
        static let menuProducts = "menu"
    }
}
