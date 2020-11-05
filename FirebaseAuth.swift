//
//  FirebaseAuth.swift
//  Check✓
//
//  Created by George Rosescu on 30/10/2020.
//

import Foundation
import Firebase

class FirebaseAuth {
    
    static func logout() {
        do {
            try Auth.auth().signOut()
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
}
