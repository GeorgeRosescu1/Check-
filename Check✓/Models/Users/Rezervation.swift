//
//  Rezervation.swift
//  Check✓
//
//  Created by George Rosescu on 07/11/2020.
//

import Foundation

struct Rezervation {
    
    var id: String?
    var ownerEmail: String!
    var restaurantEmail: String!
    var day: String!
    var hour: String!
    var numberOfGuests: Int! //including the owner
    var status: RezervationStatus!
}

enum RezervationStatus: String {
    
    case init_ = "init" //when is created
    case confirmed = "confirmed" // when is confirmed by restaurant
    case rejected  = "rejected"// when is rejected by restaurant
    case completed = "completed" // when is done
    
    case ongoing = "ongoing"// ongoing rezervation
    case closedByChecker = "closedByMe"// closed by checker, due to some reasons
}

enum ReservationConstants {
    struct FStore {
        static let collectionName = "reservations"
        
        static let id = "id"
        static let ownerEmail = "ownerEmail"
        static let restaurantEmail = "restaurantEmail"
        static let day = "day"
        static let hour = "hour"
        static let numberOfGuests = "numberOfGuests"
        static let status = "status"
    }
}
