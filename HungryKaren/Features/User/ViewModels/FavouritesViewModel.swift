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
    @Published private(set) var filteredRecipesList: [RecipeDetailsFirebase] = []
    @Published var searchText: String = "" {
        didSet {
            search()
        }
    }
    
    
    init() {
        getRecipesFromFavourites()
    }
    
    
    func deleteRecipesFromFavourites(recipe: RecipeDetailsFirebase) {
        recipesRepository.deleteRecipeFromFavourites(recipe: recipe)
    }
    
    
    private func getRecipesFromFavourites() {
        recipesRepository.getFavouritesRecipes { recipesList in
            self.favouriteRecipesList = recipesList
            self.filteredRecipesList = self.favouriteRecipesList
        }
    }
    
    
    private func search() {
        filteredRecipesList = searchText.isEmpty ? favouriteRecipesList : favouriteRecipesList.filter({
            $0.title.lowercased().contains(searchText.lowercased())
        })
    }
}
