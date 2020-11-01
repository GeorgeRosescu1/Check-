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
        } catch {
            debugPrint("Error while logging out \(error)")
        }
    }
    
}

