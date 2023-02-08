//
//  AuthenticationViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI
import Firebase

class AuthenticationViewModel: ObservableObject {
    
    private let authenticationRepository = AuthenticationRepository()
    private let userRepository = UserRepository()
    
    @Published private(set) var currentUser: FirebaseAuth.User?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var alert: AlertType? = nil
    
    init() {
        self.currentUser = authenticationRepository.getCurrentUser()
    }
    
    func signInWithEmailAndPassword(
        email: String,
        password: String,
        completion: @escaping () -> Void
    ) {
        isLoading = true
        alert = nil
        
        if email.isEmpty || password.isEmpty {
            alert = .error(message: fillAllFieldsError)
            isLoading = false
            completion()
            return
        }
        
        authenticationRepository.signInWithEmailAndPass(email: email, password: password) { user, error in
            if let error = error {
                self.alert = .error(message: error.localizedDescription)
                self.isLoading = false
                completion()
                return
            }
            
            guard let user = user else { return }
            self.currentUser = user
            self.isLoading = false
            completion()
        }
    }
    
    func signUpWithEmailAndPassword(
        email: String,
        name: String,
        password: String,
        confirmPassword: String,
        completion: @escaping () -> Void
    ) {
        isLoading = true
        alert = nil
        
        if email.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            alert = .error(message: fillAllFieldsError)
            isLoading = false
            completion()
            return
        }
        
        if password != confirmPassword {
            alert = .error(message: differentPasswordsError)
            isLoading = false
            completion()
            return
        }
        
        authenticationRepository.signUpWithEmailAndPass(email: email, password: password) { user, error in
            if let error = error {
                self.alert = .error(message: error.localizedDescription)
                self.isLoading = false
                completion()
                return
            }
            
            guard let user = user else { return }
            self.currentUser = user
            
            let userData = User(uid: user.uid, email: email, name: name)
            
            self.userRepository.saveUserData(user: userData) {
                self.isLoading = false
                completion()
            }
        }
    }
    
    func forgotPassword(email: String, completion: @escaping () -> Void) {
        
        isLoading = true
        alert = nil
        
        if email.isEmpty {
            alert = .error(message: emailAddresRequiredError)
            isLoading = false
            completion()
            return
        }
        
        authenticationRepository.resetPassword(email: email) { error in
            if let error = error {
                self.alert = .error(message: error.localizedDescription)
                self.isLoading = false
                completion()
                return
            }
            
            self.isLoading = false
            completion()
        }
    }
    
    func signOut(completion: @escaping () -> Void) {
        alert = nil
        currentUser = nil
        try? Auth.auth().signOut()
        completion()
    }
    
    func removeAlert() {
        self.alert = nil
    }
}
