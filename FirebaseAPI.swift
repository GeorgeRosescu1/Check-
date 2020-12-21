//
//  FirebaseAuth.swift
//  Check✓
//
//  Created by George Rosescu on 30/10/2020.
//

import Foundation
import Firebase

class FirebaseAPI {
    
    static let firestore = Firestore.firestore()
    
    static func logout() {
        do {
            try Auth.auth().signOut()
            Session.registeredUser = nil
            Session.isRegisterChecker = nil
            Session.isRegisterRestaurant = nil
            Session.userToken = Auth.auth().currentUser?.refreshToken
        } catch {
            debugPrint("Error while logging out \(error)")
        }
    }
    
    static func signUpUserWithEmail(_ email: String, password: String, complition: @escaping (_ result: FirebaseAuthModel) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                complition(FirebaseAuthModel(error: error, authResponse: nil))
            } else {
                Session.userToken = Auth.auth().currentUser?.refreshToken
                complition(FirebaseAuthModel(error: nil, authResponse: authResult!))
            }
        }
    }
    
    static func loginUserWithEmail(_ email: String, password: String, complition: @escaping (_ result: FirebaseAuthModel) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                complition(FirebaseAuthModel(error: error, authResponse: nil))
            } else {
                complition(FirebaseAuthModel(error: nil, authResponse: authResult!))
                Session.userToken = Auth.auth().currentUser?.refreshToken
            }
        }
    }
    
    static func getCurrentCheckerWithEmail(_ email: String, complition: @escaping ([String: Any]?) -> Void) {
        firestore.collection(CheckerConstants.FStore.collectionName).getDocuments { (snapshot, error) in
            if let _ = error {
                SwiftMessagesAlert.displaySmallErrorWithBody("Server error, please try again.")
            } else {
                let currentUserDocument = snapshot?.documents.first(where: { (docData) -> Bool in
                    let document = docData.data()
                    return document[CheckerConstants.FStore.email] as? String == email
                })
                
                let currentUserData = currentUserDocument?.data()
                
                complition(currentUserData)
            }
        }
    }
    
    static func getCurrentRestaurantWithEmail(_ email: String, complition: @escaping ([String: Any]?) -> Void) {
        firestore.collection(RestaurantConstants.FStore.collectionName).getDocuments { (snapshot, error) in
            if let _ = error {
                SwiftMessagesAlert.displaySmallErrorWithBody("Server error, please try again.")
            } else {
                let currentUserDocument = snapshot?.documents.first(where: { (docData) -> Bool in
                    let document = docData.data()
                    return document[RestaurantConstants.FStore.email] as? String == email
                })
                
                let currentUserData = currentUserDocument?.data()
                
                complition(currentUserData)
            }
        }
    }
    
    static func getAllReservationsForUserEmail(_ email: String, complition: @escaping ([Rezervation]) -> Void) {
        var rezervations = [Rezervation]()
        firestore.collection(ReservationConstants.FStore.collectionName).getDocuments { (snapshot, error) in
            if let _ = error {
                SwiftMessagesAlert.displaySmallErrorWithBody("Server error, please try again.")
            } else {
                snapshot?.documents.forEach({ (docData) in
                    let document = docData.data()
                    if document[ReservationConstants.FStore.ownerEmail] as? String == email || document[ReservationConstants.FStore.restaurantEmail] as? String == email {
                        let rezervation = Rezervation()
                        rezervation.mapReservationFromDictionary(dict: document)
                        rezervations.append(rezervation)
                    }
                })
                complition(rezervations)
            }
        }
    }
    
    static func getAllRestaurants(complition: @escaping ([Restaurant]) -> Void) {
        firestore.collection(RestaurantConstants.FStore.collectionName).getDocuments { (snapshot, error) in
            if let _ = error {
                SwiftMessagesAlert.displaySmallErrorWithBody("Server error, please try again.")
            } else {
                var restaurants = [Restaurant]()
                snapshot?.documents.forEach({ (docData) in
                    let document = docData.data()
                    let restaurant = Restaurant()
                    restaurant.mapRestaurantFromDictionary(dict: document)
                    
                    let storage = Storage.storage().reference().child(RestaurantConstants.FStore.picturesCollectionName + "/" + restaurant.pictureURL!)
                    storage.getData(maxSize: 15 * 1024 * 1024) { (data, error) in
                        if let error = error {
                            debugPrint("Error while loading the photo \(error.localizedDescription)")
                            return
                        } else {
                            guard let data = data else { return }
                            restaurant.profilePicture = UIImage(data: data)
                        }
                        restaurants.append(restaurant)
                        
                        complition(restaurants)
                    }
                })
            }
        }
    }
    
}
