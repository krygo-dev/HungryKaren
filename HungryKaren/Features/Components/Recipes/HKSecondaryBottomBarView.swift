//
//  HKSecondaryBottomBarView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 20/02/2023.
//

import SwiftUI

struct HKSecondaryBottomBarView: View {
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    @Binding var searchText: String
    @Binding var showBottomBar: Bool
    let searchBarVisible: Bool
    let searchBarButtonVisible: Bool
    @FocusState var searchFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 14) {
            if searchBarVisible {
                HKSearchBarView(
                    showFilters: .constant(false),
                    searchText: $searchText,
                    backgroundColor: quaternaryColor,
                    buttonVisible: searchBarButtonVisible,
                    searchFieldFocused: _searchFieldFocused
                )
            }
            
            HStack(spacing: 19) {
                Button {
                    navigationRouter.selectedScreen = .home
                    searchText = ""
                    navigationRouter.navigateBackToMain()
                } label: {
                    VStack {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38)
                    }
                    .frame(width: 104, height: 53)
                    .background(primaryColor)
                    .cornerRadius(15)
                }
                Button {
                    navigationRouter.selectedScreen = .fridge
                    searchText = ""
                    navigationRouter.navigateBackToMain()
                } label: {
                    VStack {
                        Image("fridge_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 53, height: 53)
                    }
                    .frame(width: 104, height: 53)
                    .background(primaryColor)
                    .cornerRadius(15)
                }
                Button {
                    navigationRouter.selectedScreen = .cart
                    searchText = ""
                    navigationRouter.navigateBackToMain()
                } label: {
                    VStack {
                        Image(systemName: "cart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38)
                    }
                    .frame(width: 104, height: 53)
                    .background(primaryColor)
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
