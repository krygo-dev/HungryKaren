//
//  HKBottomBarView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

enum Screen: Int {
    case home = 0
    case fridge = 1
    case cart = 2
}

struct HKBottomBarView: View {
    
    @Binding var selectedScreen: Screen
    @Binding var searchText: String
    @Binding var showBottomBar: Bool
    @Binding var showFilters: Bool
    let selectedColor: Color
    let deselectedColor: Color
    let searchBarColor: Color
    
    var body: some View {
        VStack(spacing: 14) {
            HKSearchBarView(
                showFilters: $showFilters,
                searchText: $searchText,
                backgroundColor: searchBarColor
            )
            
            HStack(spacing: 19) {
                Button {
                    selectedScreen = .home
                    searchText = ""
                } label: {
                    VStack {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38)
                    }
                    .frame(width: 104, height: 53)
                    .background(selectedScreen == .home ? selectedColor : deselectedColor)
                    .cornerRadius(15)
                }
                Button {
                    selectedScreen = .fridge
                    searchText = ""
                } label: {
                    VStack {
                        Image("fridge_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 53, height: 53)
                    }
                    .frame(width: 104, height: 53)
                    .background(selectedScreen == .fridge ? selectedColor : deselectedColor)
                    .cornerRadius(15)
                }
                Button {
                    selectedScreen = .cart
                    searchText = ""
                } label: {
                    VStack {
                        Image(systemName: "cart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38)
                    }
                    .frame(width: 104, height: 53)
                    .background(selectedScreen == .cart ? selectedColor : deselectedColor)
                    .cornerRadius(15)
                }
            }
        }
        .frame(height: 120)
        .tint(thirdTitleColor)
        .background(.clear)
        .padding(.horizontal, 20)
        .offset(y: showBottomBar ? 0 : 150)
    }
}

struct HKTabView_Previews: PreviewProvider {
    static var previews: some View {
        HKBottomBarView(
            selectedScreen: .constant(.home),
            searchText: .constant(""),
            showBottomBar: .constant(true),
            showFilters: .constant(false),
            selectedColor: secondaryColor,
            deselectedColor: primaryColor,
            searchBarColor: searchBarBgColor)
    }
}
