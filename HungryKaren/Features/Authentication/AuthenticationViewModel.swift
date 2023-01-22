//
//  AuthenticationViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI
import Firebase

class AuthenticationViewModel: ObservableObject {
    
    @Published var currentUser: FirebaseAuth.User?
    
    init() {
        self.currentUser = Auth.auth().currentUser
        
        print("DEBUG: \(String(describing: self.currentUser))")
    }
    
    func signInWithEmailAndPassword(email: String, password: String) {
        
    }
    
    func signUpWithEmailAndPassword(email: String, name: String, password: String, confirmPassword: String) {
        
        if email.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            print("DEBUG: Fill all fields")
            return
        }
        
        if password != confirmPassword {
            print("DEBUG: Passwords are different")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Registration failed: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.currentUser = user
            print("DEBUG: Registration success")
            
            let data = ["email": email,
                        "name": name,
                        "uis": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG: User data saved")
                }
        }
    }
    
    func forgotPassword(email: String) {
        
    }
    
    func signOut() {
        currentUser = nil
        try? Auth.auth().signOut()
    }
}

