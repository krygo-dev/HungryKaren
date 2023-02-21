//
//  ProfileViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/02/2023.
//

import SwiftUI
import Firebase

final class ProfileViewModel: ObservableObject {
    
    private let authenticationRepository: AuthenticationRepository = AuthenticationRepository()
    private let userRepository: UserRepository = UserRepository()
    
    @Published var currentUserData: User? = nil
    @Published private(set) var currentUser: FirebaseAuth.User?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var alert: AlertType? = nil
    
    init() {
        currentUser = authenticationRepository.getCurrentUser()
        
        if currentUser != nil {
            getUserData()
        }
    }
    
    
    func changeUserPassword(
        email: String,
        currentPassword: String,
        newPassword: String,
        confirmNewPassword: String,
        completion: @escaping () -> Void
    ) {
        isLoading = true
        alert = nil
        
        if email.isEmpty || currentPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty {
            alert = .error(message: fillAllFieldsError)
            isLoading = false
            completion()
            return
        }
        
        if newPassword != confirmNewPassword {
            alert = .error(message: differentPasswordsError)
            isLoading = false
            completion()
            return
        }
        
        authenticationRepository.changeUserPassword(
            email: email,
            currentPassword: currentPassword,
            newPassword: newPassword
        ) { error in
            
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
    
    func removeAlert() {
        alert = nil
        isLoading = false
    }
    
    
    private func getUserData() {
        isLoading = true
        
        userRepository.getUserData(uid: currentUser!.uid) { user in
            self.currentUserData = user
            self.isLoading = false
        }
    }
}

