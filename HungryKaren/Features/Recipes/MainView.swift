//
//  MainView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var selectedScreen: Screen = .home
    @State var showMenu: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            if selectedScreen == .home { HomeView() }
            if selectedScreen == .fridge { FridgeView() }
            if selectedScreen == .cart { CartView() }
            VStack {
                if selectedScreen == .home { HKTopBarView(title: "Home", showMenu: $showMenu) }
                if selectedScreen == .fridge { HKTopBarView(title: "Fridge", showMenu: $showMenu) }
                if selectedScreen == .cart { HKTopBarView(title: "Cart", showMenu: $showMenu) }
                
                Spacer()
                
                if selectedScreen != .fridge {
                    HKBottomBarView(
                        selectedScreen: $selectedScreen,
                        searchText: $searchText,
                        selectedColor: secondaryColor,
                        deselectedColor: primaryColor,
                        searchBarColor: searchBarBgColor)
                } else {
                    HKBottomBarView(
                        selectedScreen: $selectedScreen,
                        searchText: $searchText,
                        selectedColor: alternateSecondaryColor,
                        deselectedColor: alternatePrimaryColor,
                        searchBarColor: alternatePrimaryColor)
                }
            }
            
            if showMenu {
                MenuView(showMenu: $showMenu)
                    .transition(AnyTransition.opacity.animation(.linear(duration: 0.5)))
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
