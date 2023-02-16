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
    @Published private(set) var randomRecipesList: [RecipeDetails] = []
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
                self.randomRecipesList = result
                self.isLoading = false
            }
        }
    }
}

