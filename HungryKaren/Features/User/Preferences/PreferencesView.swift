//
//  PreferencesView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 02/02/2023.
//

import SwiftUI

struct PreferencesView: View {
    
    @StateObject var preferencesViewModel = PreferencesViewModel()
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    @State var showMenu: Bool = false
    
    var body: some View {
        ZStack {
            HKMainBackgroundCanvasView(color: tertiaryColor)
            
            VStack {
                HKTopBarView(title: "Preferences", showMenu: $showMenu, showTopBar: .constant(true))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        Group {
                            Text("DIET")
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .foregroundColor(mainTextColor)
                                .padding(.bottom, 10)
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.dietFilters[0]) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.dietFilters[1]) {
                                    preferencesViewModel.saveData()
                                }
                            }
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.dietFilters[2]) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.dietFilters[3]) {
                                    preferencesViewModel.saveData()
                                }
                            }
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.dietFilters[4]) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.dietFilters[5]) {
                                    preferencesViewModel.saveData()
                                }
                            }
                        }
                        
                        
                        Rectangle()
                            .frame(width: 316, height: 1)
                            .foregroundColor(secondaryColor)
                            .padding(.vertical)
                        
                        Group {
                            Text("MEAL TYPE")
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .foregroundColor(mainTextColor)
                                .padding(.bottom, 10)
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.mealTypeFilters[0], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.mealTypeFilters[1], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                            }
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.mealTypeFilters[2], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.mealTypeFilters[3], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                            }
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.mealTypeFilters[4], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.mealTypeFilters[5], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                            }
                        }
                        
                        Rectangle()
                            .frame(width: 316, height: 1)
                            .foregroundColor(secondaryColor)
                            .padding(.vertical)
                        
                        Group {
                            Text("CUISINE")
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .foregroundColor(mainTextColor)
                                .padding(.bottom, 10)
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.cuisineFilters[0]) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.cuisineFilters[1]) {
                                    preferencesViewModel.saveData()
                                }
                            }
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.cuisineFilters[2]) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.cuisineFilters[3]) {
                                    preferencesViewModel.saveData()
                                }
                            }
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.cuisineFilters[4]) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.cuisineFilters[5]) {
                                    preferencesViewModel.saveData()
                                }
                            }
                        }
                        
                        Rectangle()
                            .frame(width: 316, height: 1)
                            .foregroundColor(secondaryColor)
                            .padding(.vertical)
                        
                        Group {
                            Text("INTOLERANCE")
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .foregroundColor(mainTextColor)
                                .padding(.bottom, 10)
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.intoleranceFilters[0], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.intoleranceFilters[1], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                            }
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.intoleranceFilters[2], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.intoleranceFilters[3], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                            }
                            HStack(spacing: 30) {
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.intoleranceFilters[4], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                                HKSearchFilterCheckBoxView(filter: $preferencesViewModel.searchFilters.intoleranceFilters[5], bgColor: primaryColor) {
                                    preferencesViewModel.saveData()
                                }
                            }
                        }
                        .padding(.bottom, 16)
                    }
                }
                .padding(.vertical, 8)

                HKSecondaryBottomBarView(
                    searchText: .constant(""),
                    showBottomBar: .constant(true),
                    searchBarVisible: false,
                    searchBarButtonVisible: false
                )
            }
            
            
            
            if showMenu {
                MenuView(showMenu: $showMenu)
                    .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.5)))
            }
        }
        .navigationBarBackButtonHidden(true)
        .gesture(NavigateBackDragGesture(completion: { navigationRouter.navigateBack() }))
    }
}
