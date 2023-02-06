//
//  MenuView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 29/01/2023.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    @Binding var showMenu: Bool
    @Binding var selectedScreen: Screen
    
    @State private var animate: Bool = false
    
    private let animationDelay = 0.5
    private let animationDuration = 0.5
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showMenu.toggle()
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
                    if selectedScreen != .home {
                        selectedScreen = .home
                        showMenu.toggle()
                    } else {
                        navigationRouter.navigate(route: .profileView)
                    }
                } label: {
                    if selectedScreen == .home {
                        Text("My profile")
                            .opacity(animate ? 1 : 0)
                            .animation(.easeOut(duration: animationDuration).delay(animationDelay), value: animate)
                    } else {
                        Text("Home")
                            .opacity(animate ? 1 : 0)
                            .animation(.easeOut(duration: animationDuration).delay(animationDelay), value: animate)
                    }
                }
                Button {
                    if selectedScreen == .home {
                        navigationRouter.navigate(route: .favouritesView)
                    } else {
                        navigationRouter.navigate(route: .profileView)
                    }
                } label: {
                    if selectedScreen == .home {
                        Text("Favourites")
                            .opacity(animate ? 1 : 0)
                            .animation(.easeOut(duration: animationDuration).delay(animationDelay + 0.1), value: animate)
                    } else {
                        Text("My profile")
                            .opacity(animate ? 1 : 0)
                            .animation(.easeOut(duration: animationDuration).delay(animationDelay + 0.1), value: animate)
                    }
                }
                Button {
                    if selectedScreen == .home {
                        selectedScreen = .fridge
                        showMenu.toggle()
                    } else {
                        navigationRouter.navigate(route: .favouritesView)
                    }
                } label: {
                    if selectedScreen == .home {
                        Text("My fridge")
                            .opacity(animate ? 1 : 0)
                            .animation(.easeOut(duration: animationDuration).delay(animationDelay + 0.2), value: animate)
                    } else {
                        Text("Favourites")
                            .opacity(animate ? 1 : 0)
                            .animation(.easeOut(duration: animationDuration).delay(animationDelay + 0.2), value: animate)
                    }
                }
                Button {
                    if selectedScreen != .cart {
                        selectedScreen = .cart
                        showMenu.toggle()
                    } else {
                        selectedScreen = .fridge
                        showMenu.toggle()
                    }
                } label: {
                    if selectedScreen != .cart {
                        Text("Shopping list")
                            .opacity(animate ? 1 : 0)
                            .animation(.easeOut(duration: animationDuration).delay(animationDelay + 0.3), value: animate)
                    } else {
                        Text("My fridge")
                            .opacity(animate ? 1 : 0)
                            .animation(.easeOut(duration: animationDuration).delay(animationDelay + 0.3), value: animate)
                    }
                }
                Button {
                    navigationRouter.navigate(route: .preferencesView)
                } label: {
                    Text("Preferences")
                        .opacity(animate ? 1 : 0)
                        .animation(.easeOut(duration: animationDuration).delay(animationDelay + 0.4), value: animate)
                }
                Button {
                    navigationRouter.navigate(route: .settingsView)
                } label: {
                    Text("Settings")
                        .opacity(animate ? 1 : 0)
                        .animation(.easeOut(duration: animationDuration).delay(animationDelay + 0.5), value: animate)
                }
                Button {
                    authViewModel.signOut {
                        navigationRouter.navigateBackToStart()
                    }
                } label: {
                    Text("Sign out")
                        .opacity(animate ? 1 : 0)
                        .animation(.easeOut(duration: animationDuration).delay(animationDelay + 0.6), value: animate)
                }
            }
            .foregroundColor(thirdTitleColor)
            .font(.system(size: 17))
            .fontWeight(.medium)
        }
        .background(.ultraThinMaterial)
        .onAppear {
            animate = true
        }
        .onDisappear {
            animate = false
        }
    }
}
