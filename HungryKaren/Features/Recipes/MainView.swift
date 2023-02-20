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
    
    @State var showMenu: Bool = false
    @State var showBars: Bool = true
    @State var showFilters: Bool = false
    
    @FocusState var searchFieldFocused: Bool

    var body: some View {
        ZStack {

            if showBars {
                if navigationRouter.selectedScreen == .fridge {
                    HKMainBackgroundCanvasView(color: alternateTertiaryColor)
                } else {
                    HKMainBackgroundCanvasView(color: tertiaryColor)
                }
            }
            
            VStack {
                if showBars {
                    if navigationRouter.selectedScreen == .home {
                        HKTopBarView(title: "Home", showMenu: $showMenu, showTopBar: $showBars)
                    }
                    if navigationRouter.selectedScreen == .fridge {
                        HKTopBarView(title: "Fridge", showMenu: $showMenu, showTopBar: $showBars)
                    }
                    if navigationRouter.selectedScreen == .cart {
                        HKTopBarView(title: "Cart", showMenu: $showMenu, showTopBar: $showBars)
                    }
                }
                
                switch navigationRouter.selectedScreen {
                    case .home: HomeView(showTopBar: $showBars).environmentObject(homeViewModel)
                    case .fridge: FridgeView().environmentObject(fridgeViewModel)
                    case .cart: CartView().environmentObject(cartViewModel)
                }
                
                if showBars {
                    switch navigationRouter.selectedScreen {
                    case .home:
                        HKBottomBarView(
                            selectedScreen: $navigationRouter.selectedScreen,
                            searchText: $homeViewModel.searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: secondaryColor,
                            deselectedColor: primaryColor,
                            searchBarColor: quaternaryColor,
                            searchBarButtonVisible: true,
                            searchFieldFocused: _searchFieldFocused)
                    case .fridge:
                        HKBottomBarView(
                            selectedScreen: $navigationRouter.selectedScreen,
                            searchText: $fridgeViewModel.searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: alternateSecondaryColor,
                            deselectedColor: alternatePrimaryColor,
                            searchBarColor: alternatePrimaryColor,
                            searchBarButtonVisible: false,
                            searchFieldFocused: _searchFieldFocused)
                    case .cart:
                        HKBottomBarView(
                            selectedScreen: $navigationRouter.selectedScreen,
                            searchText: $cartViewModel.searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: secondaryColor,
                            deselectedColor: primaryColor,
                            searchBarColor: quaternaryColor,
                            searchBarButtonVisible: false)
                    }
                }
            }
            
            if showMenu {
                MenuView(showMenu: $showMenu)
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
