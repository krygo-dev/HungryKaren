//
//  MainView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var selectedScreen: Screen = .home
    
    var body: some View {
        ZStack {
            if selectedScreen == .home { HomeView() }
            if selectedScreen == .fridge { FridgeView() }
            if selectedScreen == .cart { CartView() }
            VStack {
                Spacer()
                HKBottomBarView(selectedScreen: $selectedScreen)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
