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
    let selectedColor: Color
    let deselectedColor: Color
    let searchBarColor: Color
    
    @State private var search: String = ""
    
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                TextField(
                    "",
                    text: $search,
                    prompt: Text("Search").foregroundColor(mainTextColor)
                )
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                
                Image(systemName: "line.horizontal.3.decrease")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 19, height: 19)
                    .foregroundColor(mainTextColor)
            }
            .frame(height: 53)
            .padding(.horizontal, 17)
            .background(searchBarColor)
            .cornerRadius(15)
            .foregroundColor(secondTitleColor)
            .fontWeight(.medium)
            
            HStack(spacing: 19) {
                Button {
                    selectedScreen = .home
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
        .frame(width: .infinity, height: 120)
        .tint(thirdTitleColor)
        .background(.clear)
        .padding(.horizontal, 20)
    }
}

struct HKTabView_Previews: PreviewProvider {
    static var previews: some View {
        HKBottomBarView(
            selectedScreen: .constant(.home),
            selectedColor: secondaryColor,
            deselectedColor: primaryColor,
            searchBarColor: searchBarBgColor)
    }
}
