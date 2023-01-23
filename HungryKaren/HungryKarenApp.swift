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
    @State public var path: [Routes] = []
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                SplashView(path: $path)
                    .navigationDestination(for: Routes.self) { route in
                        switch route {
                            case .splashView: SplashView(path: $path)
                            case .startView: StartView()
                            case .signInView: SignInVIew(path: $path)
                            case .signUpView: SignUpView(path: $path)
                            case .forgotPasswordView: ForgotPasswordView(path:$path)
                            case .homeView: HomeView(path: $path)
                        }
                    }
            }
            .environmentObject(authViewModel)
            .navigationBarBackButtonHidden(true)
        }
    }
}
