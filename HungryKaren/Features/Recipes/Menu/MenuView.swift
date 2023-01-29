//
//  MenuView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 29/01/2023.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
                .foregroundColor(thirdTitleColor)
                .fontWeight(.medium)
                .frame(height: 30)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                Spacer()
            }
            VStack(spacing: 15) {
                Button {
                    print("Menu item")
                } label: {
                    Text("My profile")
                }
                Button {
                    print("Menu item")
                } label: {
                    Text("Favourites")
                }
                Button {
                    print("Menu item")
                } label: {
                    Text("My fridge")
                }
                Button {
                    print("Menu item")
                } label: {
                    Text("Shopping list")
                }
                Button {
                    print("Menu item")
                } label: {
                    Text("Preferences")
                }
                Button {
                    print("Menu item")
                } label: {
                    Text("Settings")
                }
                Button {
                    print("Menu item")
                } label: {
                    Text("Sign out")
                }
            }
            .foregroundColor(thirdTitleColor)
            .font(.system(size: 17))
            .fontWeight(.medium)
        }
        .background(.ultraThinMaterial)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(showMenu: .constant(true))
    }
}
