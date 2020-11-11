//
//  Rezervation.swift
//  Check✓
//
//  Created by George Rosescu on 07/11/2020.
//

import Foundation

struct Rezervation {
    
    var owner: Checker!
    var restaurant: Restaurant!
    var dateAndTime: Date!
    var maximumDelay: String!
    var numberOfGuests: Int! //including the owner
    var observations: String!
    var status: RezervationStatus!
    var orderedProducts: [Product]?
}

enum RezervationStatus {
    
    case init_ //when is created
    case confirmed // when is confirmed by restaurant
    case rejected // when is rejected by restaurant
    case completed // when is done
    
    case ongoing // ongoing rezervation
    case future // future rezervation
    case closedByChecker // closed by checker, due to some reasons
}
