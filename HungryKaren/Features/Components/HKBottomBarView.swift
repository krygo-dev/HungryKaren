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
    
    var body: some View {
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
                .background(selectedScreen == .home ? secondaryColor : primaryColor)
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
                .background(selectedScreen == .fridge ? secondaryColor : primaryColor)
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
                .background(selectedScreen == .cart ? secondaryColor : primaryColor)
                .cornerRadius(15)
            }
        }
        .frame(width: .infinity, height: 53)
        .tint(thirdTitleColor)
    }
}

struct HKTabView_Previews: PreviewProvider {
    static var previews: some View {
        HKBottomBarView(selectedScreen: .constant(.home))
    }
}
