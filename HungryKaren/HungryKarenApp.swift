//
//  HungryKarenApp.swift
//  HungryKaren
//
//  Created by Ewelina Klekot on 20/01/2023.
//

import SwiftUI
import Firebase

@main
struct HungryKarenApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
