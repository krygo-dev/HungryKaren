//
//  UserRepository.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 06/02/2023.
//

import Firebase

class UserRepository {
    private let fbFirestore = Firestore.firestore()
    private let collectionPath = "users"
    
    func saveUserData(user: User, completion: @escaping () -> Void) {
        
        let userData = ["email": user.email,
                        "name": user.name,
                        "uid": user.uid]
        
        fbFirestore.collection(collectionPath)
            .document(user.uid)
            .setData(userData) { _ in
                completion()
            }
    }
}
