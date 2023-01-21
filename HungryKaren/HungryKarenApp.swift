//
//  HungryKarenApp.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 20/01/2023.
//

import SwiftUI
import Firebase

@main
struct HungryKarenApp: App {
    
    @StateObject var authViewModel = AuthenticationViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(authViewModel)
//            StartView()
        }
    }
}
