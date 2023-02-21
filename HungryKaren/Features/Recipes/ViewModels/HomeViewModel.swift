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
    private let userRepository: UserRepository = UserRepository()
    private let authenticationRepository: AuthenticationRepository = AuthenticationRepository()
    
    @Published private(set) var recipesList: [Recipe] = []
    @Published private(set) var recipesDetailsList: [RecipeDetails] = []
    @Published private(set) var recipesDetailsListCopy: [RecipeDetails] = []
    @Published private(set) var favouriteRecipesList: [RecipeDetailsFirebase] = []
    @Published var showRecipeDetailsDictionary = [Int: Bool]()
    
    @Published var searchQuery: Query = Query(query: "", searchFilters: SearchFilters())
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var alert: AlertType? = nil
    
    @Published var searchText: String = "" {
        didSet {
            searchForRecipes()
        }
    }
    
    @Published var currentUser: User? = nil
    
    private var workItem: DispatchWorkItem?
    
    init() {
        userRepository.getUserData(uid: authenticationRepository.getCurrentUser()!.uid) { user in
            self.currentUser = user
            self.convertUserPreferences()
        }
        
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
                self.recipesDetailsListCopy = self.recipesDetailsList
                self.showRecipeDetailsDictionary = self.recipesDetailsList.reduce(into: [Int: Bool]()) { result, value in
                    result[value.id] = false
                }
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
    
    
    func showDetails(recipeId: Int) {
        showRecipeDetailsDictionary[recipeId]?.toggle()
        
        if showRecipeDetailsDictionary[recipeId]! {
            recipesDetailsList = [recipesDetailsList.first(where: { $0.id == recipeId })!]
        } else {
            recipesDetailsList = recipesDetailsListCopy
        }
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
                self.recipesDetailsListCopy = self.recipesDetailsList
                self.showRecipeDetailsDictionary = self.recipesDetailsList.reduce(into: [Int: Bool]()) { result, value in
                    result[value.id] = false
                }
                self.isLoading = false
            }
        }
    }
    
    
    private func getRecipesFromFavourites() {
        recipesRepository.getFavouritesRecipes { recipesList in
            self.favouriteRecipesList = recipesList
        }
    }
    
    
    private func convertUserPreferences() {
        
        currentUser?.preferences[cuisine]?.forEach { name in
            if !name.isEmpty {
                searchQuery.searchFilters.cuisineFilters[searchQuery.searchFilters.cuisineFilters.firstIndex(where: { $0.name == name })!].isSelected = true
            }
        }
        
        currentUser?.preferences[diet]?.forEach { name in
            if !name.isEmpty {
                searchQuery.searchFilters.dietFilters[searchQuery.searchFilters.dietFilters.firstIndex(where: { $0.name == name })!].isSelected = true
            }
        }
        
        currentUser?.preferences[intolerance]?.forEach { name in
            if !name.isEmpty {
                searchQuery.searchFilters.intoleranceFilters[searchQuery.searchFilters.intoleranceFilters.firstIndex(where: { $0.name == name })!].isSelected = true
            }
        }
        
        currentUser?.preferences[mealType]?.forEach { name in
            if !name.isEmpty {
                searchQuery.searchFilters.mealTypeFilters[searchQuery.searchFilters.mealTypeFilters.firstIndex(where: { $0.name == name })!].isSelected = true
            }
        }
    }
}

