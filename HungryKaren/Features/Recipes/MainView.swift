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
    
    @StateObject var searchFilters: SearchFilters = SearchFilters()
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
                if selectedScreen == .fridge { FridgeView(searchFieldFocused: _searchFieldFocused).environmentObject(fridgeViewModel) }
                if selectedScreen == .cart { CartView().environmentObject(cartViewModel) }
                
                if showBars {
                    if selectedScreen != .fridge {
                        HKBottomBarView(
                            selectedScreen: $selectedScreen,
                            searchText: $searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: secondaryColor,
                            deselectedColor: primaryColor,
                            searchBarColor: quaternaryColor)
                    } else {
                        HKBottomBarView(
                            selectedScreen: $selectedScreen,
                            searchText: $fridgeViewModel.searchText,
                            showBottomBar: $showBars,
                            showFilters: $showFilters,
                            selectedColor: alternateSecondaryColor,
                            deselectedColor: alternatePrimaryColor,
                            searchBarColor: alternatePrimaryColor,
                            searchFieldFocused: _searchFieldFocused)
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
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        if !fridgeViewModel.foundIngredientsList.isEmpty {
                            ForEach(fridgeViewModel.foundIngredientsList) { ingredient in
                                HKFoundIngredientListItemView(ingredient: ingredient) {
                                    fridgeViewModel.product.name = ingredient.name
                                    fridgeViewModel.showAddQuantityDialog.toggle()
                                }
                            }
                        }
                    }
                }
                .frame(width: 390, height: 500, alignment: .bottom)
                .background(.white)
                .cornerRadius(25)
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
                }
            }
            

            VStack {
                Spacer()
                SearchFiltersView(
                    showFilters: $showFilters,
                    searchFilters: searchFilters
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
