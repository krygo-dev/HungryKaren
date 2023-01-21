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
        
        print("DEBUG: \(self.currentUser)")
    }
    
}
