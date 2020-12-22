//
//  Rezervation.swift
//  Check✓
//
//  Created by George Rosescu on 07/11/2020.
//

import Foundation

class Rezervation {
    
    var id: String?
    var ownerEmail: String!
    var restaurantEmail: String!
    var day: String!
    var hour: String!
    var numberOfGuests: Int! //including the owner
    var status: RezervationStatus!
    
    func mapReservationFromDictionary(dict: [String: Any]?) {
        self.id = dict?[ReservationConstants.FStore.id] as? String
        self.ownerEmail = dict?[ReservationConstants.FStore.ownerEmail] as? String
        self.restaurantEmail = dict?[ReservationConstants.FStore.restaurantEmail] as? String
        self.day = dict?[ReservationConstants.FStore.day] as? String
        self.hour = dict?[ReservationConstants.FStore.hour] as? String
        
        let statusString = dict?[ReservationConstants.FStore.status] as? String
        self.status = RezervationStatus(rawValue: statusString!)
    }
}

enum RezervationStatus: String {
    
    case init_ = "Panding" //when is created
    case confirmed = "Confirmed" // when is confirmed by restaurant
    case rejected  = "Rejected"// when is rejected by restaurant
    case completed = "Completed" // when is done
    
    case ongoing = "Ongoing"// ongoing rezervation
    case closedByChecker = "Closed"// closed by checker, due to some reasons
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
