//
//  AuthenticationRepository.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import Firebase

class AuthenticationRepository {
    
    private let fbAuth = Auth.auth()
    
    func getCurrentUser() -> FirebaseAuth.User? {
        return fbAuth.currentUser
    }
    
    func signInWithEmailAndPass(
        email: String,
        password: String,
        completion: @escaping (FirebaseAuth.User?, Error?) -> Void
    ) {
        fbAuth.signIn(withEmail: email, password: password) { result, error in
            completion(result?.user, error)
        }
    }
    
    func signUpWithEmailAndPass(
        email: String,
        password: String,
        completion: @escaping (FirebaseAuth.User?, Error?) -> Void
    ) {
        fbAuth.createUser(withEmail: email, password: password) { result, error in
            completion(result?.user, error)
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        fbAuth.sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    func signOut() {
        try? fbAuth.signOut()
    }
}
