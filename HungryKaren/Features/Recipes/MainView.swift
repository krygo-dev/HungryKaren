//
//  MainView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    @State var selectedScreen: Screen = .home
    @State var showMenu: Bool = false
    @State var showBars: Bool = true
    @State var showFilters: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {

            if showBars {
                if selectedScreen == .fridge {
                    HKMainBackgroundCanvasView(color: alternateTertiaryColor)
                } else {
                    HKMainBackgroundCanvasView(color: tertiaryColor)
                }
            }
            
            VStack {
                if showBars {
                    if selectedScreen == .home {
                        HKTopBarView(title: "Home", showMenu: $showMenu, showTopBar: $showBars)
                    }
                    if selectedScreen == .fridge {
                        HKTopBarView(title: "Fridge", showMenu: $showMenu, showTopBar: $showBars)
                    }
                    if selectedScreen == .cart {
                        HKTopBarView(title: "Cart", showMenu: $showMenu, showTopBar: $showBars)
                    }
                }

                if selectedScreen == .home { HomeView(showTopBar: $showBars) }
                if selectedScreen == .fridge { FridgeView() }
                if selectedScreen == .cart { CartView() }
                
                if showBars {
                    if selectedScreen != .fridge {
                        HKBottomBarView(
                            selectedScreen: $selectedScreen,
                            searchText: $searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: secondaryColor,
                            deselectedColor: primaryColor,
                            searchBarColor: searchBarBgColor)
                    } else {
                        HKBottomBarView(
                            selectedScreen: $selectedScreen,
                            searchText: $searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: alternateSecondaryColor,
                            deselectedColor: alternatePrimaryColor,
                            searchBarColor: alternatePrimaryColor)
                    }
                }
            }
            
            if showMenu {
                MenuView(
                    showMenu: $showMenu,
                    selectedScreen: $selectedScreen
                )
                .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.5)))
            }
            
            if showFilters {
                SearchFiltersView(showFilters: $showFilters)
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
