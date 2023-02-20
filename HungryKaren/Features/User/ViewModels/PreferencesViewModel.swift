//
//  PreferencesViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 17/02/2023.
//

import Foundation

final class PreferencesViewModel: ObservableObject {
    
    private let userRepository: UserRepository = UserRepository()
    private let authenticationRepository: AuthenticationRepository = AuthenticationRepository()
    
    @Published var currentUser: User? = nil
    
    init() {
        userRepository.getUserData(uid: authenticationRepository.getCurrentUser()!.uid) { user in
            self.currentUser = user
        }
    }
}
