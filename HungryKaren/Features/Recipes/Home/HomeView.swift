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
    
    @State var showDetails: Bool = false
    @State var offset: CGFloat = 0
    @State var previousOffset: CGFloat = 0
    @Binding var showTopBar: Bool
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Recipes ideas")
                        .font(.system(size: 22))
                        .fontWeight(.medium)
                        .foregroundColor(secondTitleColor)
                        .padding(.leading, 17)
                    Spacer()
                }
                
                if !homeViewModel.recipesDetailsList.isEmpty {
                    ForEach(homeViewModel.recipesDetailsList) { recipe in
                        HKRecipeListItemView(
                            recipe: recipe,
                            recipeInFav: homeViewModel.favouriteRecipesList.contains(where: { $0.id == recipe.id }),
                            showDetails: $homeViewModel.showRecipeDetailsDictionary,
                            onItemTap: {
                                withAnimation {
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
        .coordinateSpace(name: "SCROLL")
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
}
