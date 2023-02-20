//
//  NavigationRouter.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 24/01/2023.
//

import SwiftUI

class NavigationRouter: ObservableObject {
    @Published var path = [Route]()
    @Published var selectedScreen: Screen = .home
    
    func navigate(route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateBackToStart() {
        path = [.startView]
    }
    
    func navigateBackToMain() {
        path = [.mainView]
    }
}
