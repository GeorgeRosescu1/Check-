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
    
    
}
