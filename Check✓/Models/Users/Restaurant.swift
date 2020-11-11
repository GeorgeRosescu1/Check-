//
//  Restaurant.swift
//  Check✓
//
//  Created by George Rosescu on 07/11/2020.
//

import Foundation

struct Restaurant {
    
    var name: String!
    var address: String!
    var phoneNumber: String!
    var openingHour: Date!
    var closingHour: Date!
    var menu: [Product]!
    var description: String!
    var pictureURL: String!
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
}
