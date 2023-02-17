//
//  HomeViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 06/02/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    private let recipesRepository: RecipesRespository = RecipesRespository()
    private let productRepository: ProductsRepository = ProductsRepository()
    
    @Published private(set) var recipesList: [Recipe] = []
    @Published private(set) var recipesDetailsList: [RecipeDetails] = []
    @Published private(set) var favouriteRecipesList: [RecipeDetailsFirebase] = []
    
    @Published var searchQuery: Query = Query(query: "", searchFilters: SearchFilters())
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var alert: AlertType? = nil
    
    @Published var searchText: String = "" {
        didSet {
            searchForRecipes()
        }
    }
    private var workItem: DispatchWorkItem?
    
    init() {
        productRepository.getProductsInFridge { productsList in
            let productsNames = productsList.map { $0.name }
            if productsNames.count > 0 {
                self.getRecipesByIngredients(namesList: productsNames)
            } else {
                self.getRandomRecipes()
            }
        }
        
        getRecipesFromFavourites()
    }
    
    
    func searchForRecipes() {
        workItem?.cancel()
        isLoading = true
        alert = nil
        
        if searchText.isEmpty { return }
        
        searchQuery.query = searchText

        let item = DispatchWorkItem {
            self.recipesRepository.fetchRecipesByComplexSearch(searchQuery: self.searchQuery) { result, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.alert = .error(message: error)
                        self.isLoading = false
                        return
                    }

                    guard let result = result else { return }
                    self.recipesList = result.results
                    self.getRecipesDetails()
                    self.isLoading = false
                }
            }
        }
        
        workItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem!)
        return
    }
    
    
    func getRecipesByIngredients(namesList: [String]) {
        isLoading = true
        alert = nil
        recipesRepository.fetchRecipesByIngredients(ingredients: namesList) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alert = .error(message: error)
                    self.isLoading = false
                    return
                }
                
                guard let result = result else { return }
                self.recipesList = result
                self.getRecipesDetails()
                self.isLoading = false
            }
        }
    }
    
    
    func getRandomRecipes() {
        isLoading = true
        alert = nil
        recipesRepository.getRandomRecipes { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alert = .error(message: error)
                    self.isLoading = false
                    return
                }
                
                guard let result = result else { return }
                self.recipesDetailsList = result
                self.isLoading = false
            }
        }
    }
    
    
    func addRecipeToFavourites(recipe: RecipeDetails) {
        recipesRepository.addRecipeToFavourites(recipe: recipe)
    }
    
    
    func deleteRecipesFromFavourites(recipe: RecipeDetails) {
        guard let recipeToDelete = favouriteRecipesList.first(where: { $0.id == recipe.id }) else { return }
        recipesRepository.deleteRecipeFromFavourites(recipe: recipeToDelete)
    }
    
    
    private func getRecipesDetails() {
        isLoading = true
        alert = nil
        
        let recipesIdsList = recipesList.map { recipe in
            recipe.id
        }
        
        recipesRepository.getRecipesDetailsBulk(recipesIds: recipesIdsList) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alert = .error(message: error)
                    self.isLoading = false
                    return
                }
                
                guard let result = result else { return }
                self.recipesDetailsList = result
                self.isLoading = false
            }
        }
    }
    
    
    private func getRecipesFromFavourites() {
        recipesRepository.getFavouritesRecipes { recipesList in
            self.favouriteRecipesList = recipesList
        }
    }
}

