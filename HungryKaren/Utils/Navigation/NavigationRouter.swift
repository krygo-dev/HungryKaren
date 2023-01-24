//
//  NavigationRouter.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 24/01/2023.
//

import SwiftUI

class NavigationRouter: ObservableObject {
    @Published var path = [Route]()
}
