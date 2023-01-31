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
    @StateObject var navigationRouter = NavigationRouter()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationRouter.path) {
                SplashView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .splashView: SplashView()
                            case .startView: StartView()
                            case .signInView: SignInVIew()
                            case .signUpView: SignUpView()
                            case .forgotPasswordView: ForgotPasswordView()
                            case .mainView: MainView()
                        }
                    }
            }
            .environmentObject(authViewModel)
            .environmentObject(navigationRouter)
            .navigationBarBackButtonHidden(true)
        }
    }
}
