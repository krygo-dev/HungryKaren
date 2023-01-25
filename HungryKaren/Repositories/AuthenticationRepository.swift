//
//  AuthenticationRepository.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import Firebase

class AuthenticationRepository {
    
    private let firebaseAuth = Auth.auth()
    
    func getCurrentUser() -> FirebaseAuth.User? {
        return firebaseAuth.currentUser
    }
    
    func signInWithEmailAndPass(
        email: String,
        password: String,
        completion: @escaping (FirebaseAuth.User?, Error?) -> Void
    ) {
        firebaseAuth.signIn(withEmail: email, password: password) { result, error in
            completion(result?.user, error)
        }
    }
}
