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
    @Published var showRecipeDetailsDictionary = [Int: Bool]()
    
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
    
    
    func showDetails(recipeId: Int) {
        showRecipeDetailsDictionary[recipeId]?.toggle()
        
        if showRecipeDetailsDictionary[recipeId]! {
            filteredRecipesList = [filteredRecipesList.first(where: { $0.id == recipeId })!]
        } else {
            filteredRecipesList = favouriteRecipesList
        }
    }
    
    
    private func getRecipesFromFavourites() {
        recipesRepository.getFavouritesRecipes { recipesList in
            self.favouriteRecipesList = recipesList
            self.filteredRecipesList = self.favouriteRecipesList
            self.showRecipeDetailsDictionary = self.favouriteRecipesList.reduce(into: [Int: Bool]()) { result, value in
                result[value.id] = false
            }
        }
    }
    
    
    private func search() {
        filteredRecipesList = searchText.isEmpty ? favouriteRecipesList : favouriteRecipesList.filter({
            $0.title.lowercased().contains(searchText.lowercased())
        })
        showRecipeDetailsDictionary = self.favouriteRecipesList.reduce(into: [Int : Bool]()) { result, value in
            result[value.id] = false
        }
    }
}
