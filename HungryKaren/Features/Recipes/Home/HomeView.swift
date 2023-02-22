//
//  HomeView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    @State var offset: CGFloat = 0
    @State var previousOffset: CGFloat = 0
    @State var disableScroll: Bool = false
    @Binding var showTopBar: Bool
    
    var body: some View {
        if homeViewModel.isLoading {
            Spacer()
            ProgressView()
            Spacer()
        } else if homeViewModel.alert != nil {
            Spacer()
            Text(homeViewModel.alert!.message())
                .font(.system(size: 15))
                .fontWeight(.medium)
                .foregroundColor(secondTitleColor)
            Spacer()
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 3) {
                    if homeViewModel.recipesDetailsList.count > 1 {
                        HStack {
                            Text("Recipes ideas")
                                .font(.system(size: 22))
                                .fontWeight(.medium)
                                .foregroundColor(secondTitleColor)
                                .padding(.leading, 17)
                            Spacer()
                        }
                    }
                    
                    if !homeViewModel.recipesDetailsList.isEmpty {
                        ForEach(homeViewModel.recipesDetailsList) { recipe in
                            HKRecipeListItemView(
                                recipe: recipe,
                                recipeInFav: homeViewModel.favouriteRecipesList.contains(where: { $0.id == recipe.id }),
                                showDetails: $homeViewModel.showRecipeDetailsDictionary,
                                onItemTap: {
                                    withAnimation {
                                        disableScroll.toggle()
                                        homeViewModel.showDetails(recipeId: recipe.id)
                                    }
                                },
                                onHeartTap: {
                                    if homeViewModel.favouriteRecipesList.contains(where: { $0.id == recipe.id }) {
                                        homeViewModel.deleteRecipesFromFavourites(recipe: recipe)
                                    } else {
                                        homeViewModel.addRecipeToFavourites(recipe: recipe)
                                    }
                                }
                            )
                        }
                    }
                }
                .padding(.vertical, 40)
                .padding(.horizontal, 20)
                .overlay {
                    GeometryReader { proxy -> Color in
                        
                        let minY = proxy.frame(in: .named("SCROLL")).minY
                        let durationOffset: CGFloat = 35
                        
                        DispatchQueue.main.async {
                            
                            if minY < offset {
                                if offset < 0 && -minY > (previousOffset + durationOffset) {
                                    withAnimation(.easeOut.speed(1.5)) {
                                        showTopBar = false
                                    }
                                    
                                    previousOffset = -offset
                                }
                            }
                            
                            if minY > offset && -minY < (previousOffset - durationOffset) {
                                withAnimation(.easeOut.speed(1.5)) {
                                    showTopBar = true
                                }

                                previousOffset = -offset
                            }
                            
                            
                            self.offset = minY
                        }
                        return Color.clear
                    }
                }
            }
            .scrollDisabled(disableScroll)
            .coordinateSpace(name: "SCROLL")
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
        }
        }

    }
}
