//
//  FavouritesViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 17/02/2023.
//

import Foundation

final class FavouritesViewModel: ObservableObject {
    
    private let recipesRepository: RecipesRespository = RecipesRespository()
    
    @Published private(set) var favouriteRecipesList: [RecipeDetailsFirebase] = []
    
    
    init() {
        getRecipesFromFavourites()
    }
    
    
    func deleteRecipesFromFavourites(recipe: RecipeDetailsFirebase) {
        recipesRepository.deleteRecipeFromFavourites(recipe: recipe)
    }
    
    
    private func getRecipesFromFavourites() {
        recipesRepository.getFavouritesRecipes { recipesList in
            self.favouriteRecipesList = recipesList
        }
    }
}
