//
//  FavouritesView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 02/02/2023.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject var favouritesViewModel: FavouritesViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    @State var showMenu: Bool = false
    @State var showBars: Bool = true
    @State var disableScroll: Bool = false
    @State var offset: CGFloat = 0
    @State var previousOffset: CGFloat = 0

    
    var body: some View {
        ZStack {
            if showBars { HKMainBackgroundCanvasView(color: tertiaryColor) }
            
            VStack {
                
                if showBars { HKTopBarView(title: "Favourites", showMenu: $showMenu, showTopBar: $showBars) }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 3) {
                        if !favouritesViewModel.favouriteRecipesList.isEmpty {
                            ForEach(favouritesViewModel.filteredRecipesList) { recipe in
                                HKRecipeListItemView(
                                    recipe: RecipeDetails(from: recipe),
                                    recipeInFav: favouritesViewModel.favouriteRecipesList.contains(where: { $0.id == recipe.id }),
                                    showDetails: $favouritesViewModel.showRecipeDetailsDictionary,
                                    onItemTap: {
                                        withAnimation {
                                            disableScroll.toggle()
                                            favouritesViewModel.showDetails(recipeId: recipe.id)
                                        }
                                    },
                                    onHeartTap: {
                                        if favouritesViewModel.favouriteRecipesList.contains(where: { $0.id == recipe.id }) {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                favouritesViewModel.deleteRecipesFromFavourites(recipe: recipe)
                                            }
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
                                            showBars = false
                                        }
        
                                        previousOffset = -offset
                                    }
                                }
        
                                if minY > offset && -minY < (previousOffset - durationOffset) {
                                    withAnimation(.easeOut.speed(1.5)) {
                                        showBars = true
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
                .animation(.easeIn(duration: 0.3), value: favouritesViewModel.filteredRecipesList)
                .coordinateSpace(name: "SCROLL")
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
                .onDisappear {
                    UIScrollView.appearance().bounces = true
                }
                
                if showBars {
                    HKSecondaryBottomBarView(
                        searchText: $favouritesViewModel.searchText,
                        showBottomBar: $showBars,
                        searchBarVisible: true,
                        searchBarButtonVisible: false
                    )
                }
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
