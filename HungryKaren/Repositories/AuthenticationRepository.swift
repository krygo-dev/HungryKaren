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
    
    func changeUserPassword(email: String, currentPassword: String, newPassword: String, completion: @escaping (Error?) -> Void) {
        let credentials = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        
        fbAuth.currentUser?.reauthenticate(with: credentials) { result, error in
            if let error = error{
                completion(error)
            } else {
                self.fbAuth.currentUser?.updatePassword(to: newPassword) { error in
                    completion(error)
                }
            }
        }
    }
    
    func signOut() {
        try? fbAuth.signOut()
    }
}
