//
//  Route.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 22/01/2023.
//

enum Route: Hashable {
    case startView
    case signInView
    case signUpView
    case forgotPasswordView
    case mainView
    case profileView
    case favouritesView
    case preferencesView
}


enum Screen: Int {
    case home = 0
    case fridge = 1
    case cart = 2
}
