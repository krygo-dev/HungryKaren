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
    
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var cartViewModel = CartViewModel()
    @StateObject var fridgeViewModel = FridgeViewModel()
    
    @State var selectedScreen: Screen = .home
    @State var showMenu: Bool = false
    @State var showBars: Bool = true
    @State var showFilters: Bool = false
    @State var searchText: String = ""
    
    @FocusState var searchFieldFocused: Bool

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

                if selectedScreen == .home { HomeView(showTopBar: $showBars).environmentObject(homeViewModel) }
                if selectedScreen == .fridge { FridgeView().environmentObject(fridgeViewModel) }
                if selectedScreen == .cart { CartView().environmentObject(cartViewModel) }
                
                if showBars {
                    switch selectedScreen {
                    case .home:
                        HKBottomBarView(
                            selectedScreen: $selectedScreen,
                            searchText: $homeViewModel.searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: secondaryColor,
                            deselectedColor: primaryColor,
                            searchBarColor: quaternaryColor,
                            searchFieldFocused: _searchFieldFocused)
                    case .fridge:
                        HKBottomBarView(
                            selectedScreen: $selectedScreen,
                            searchText: $fridgeViewModel.searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: alternateSecondaryColor,
                            deselectedColor: alternatePrimaryColor,
                            searchBarColor: alternatePrimaryColor,
                            searchFieldFocused: _searchFieldFocused)
                    case .cart:
                        HKBottomBarView(
                            selectedScreen: $selectedScreen,
                            searchText: $searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: secondaryColor,
                            deselectedColor: primaryColor,
                            searchBarColor: quaternaryColor)
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
            
            
            if !fridgeViewModel.searchText.isEmpty {
                HKIngredientSearchResultListView()
                    .environmentObject(fridgeViewModel)
            }
            
            
            if fridgeViewModel.showAddQuantityDialog {
                HKAlertView(alertType: .info(message: "Provide quantity and category"), quantity: $fridgeViewModel.product.quantity, isSpice: $fridgeViewModel.product.isSpice) {
                    
                    if fridgeViewModel.product.quantity.isEmpty {
                        return
                    }

                    fridgeViewModel.addProduct()
                    fridgeViewModel.searchText = ""
                    fridgeViewModel.product = FridgeProduct(name: "", quantity: "", isSpice: false)
                    searchFieldFocused = false
                    fridgeViewModel.showAddQuantityDialog.toggle()
                } onCloseAction: {
                    fridgeViewModel.showAddQuantityDialog.toggle()
                }
            }
            

            VStack {
                Spacer()
                SearchFiltersView(
                    showFilters: $showFilters,
                    searchFilters: homeViewModel.searchQuery.searchFilters
                )
                .offset(y: showFilters ? 0 : 900)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .background(showFilters ? .black.opacity(0.35) : .clear)
            .onTapGesture {
                withAnimation(.easeOut.speed(0.7)) {
                    showFilters.toggle()
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            showMenu = false
            showBars = true
            showFilters = false
            searchText = ""
            
            if authViewModel.userData?.preferences["cuisine"] != "" {
                homeViewModel.searchQuery.searchFilters.cuisineFilters[
                    homeViewModel.searchQuery.searchFilters.cuisineFilters.firstIndex(
                        where: { $0.name == authViewModel.userData?.preferences["cuisine"]! }
                    )!
                ].isSelected = true
            }
            
            if authViewModel.userData?.preferences["diet"] != "" {
                homeViewModel.searchQuery.searchFilters.dietFilters[
                    homeViewModel.searchQuery.searchFilters.dietFilters.firstIndex(
                        where: { $0.name == authViewModel.userData?.preferences["diet"]! }
                    )!
                ].isSelected = true
            }
            
            if authViewModel.userData?.preferences["intolerance"] != "" {
                homeViewModel.searchQuery.searchFilters.intoleranceFilters[
                    homeViewModel.searchQuery.searchFilters.intoleranceFilters.firstIndex(
                        where: { $0.name == authViewModel.userData?.preferences["intolerance"]! }
                    )!
                ].isSelected = true
            }
            
            if authViewModel.userData?.preferences["mealType"] != "" {
                homeViewModel.searchQuery.searchFilters.mealTypeFilters[
                    homeViewModel.searchQuery.searchFilters.mealTypeFilters.firstIndex(
                        where: { $0.name == authViewModel.userData?.preferences["mealType"]! }
                    )!
                ].isSelected = true
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//            .environmentObject(AuthenticationViewModel())
//            .environmentObject(NavigationRouter())
//    }
//}
