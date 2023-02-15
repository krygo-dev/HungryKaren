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
    @Published var searchQuery: Query = Query(query: "soup", searchFilters: SearchFilters())
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var alert: AlertType? = nil
    
    init() {
//        productRepository.getProductsInFridge { productsList in
//            let productsNames = productsList.map { $0.name }
//            self.getRecipesByIngredients(namesList: productsNames)
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getRecipes {
                print("DEBUG: Fetched")
                print("DEBUG: \(self.searchQuery)")
            }
        }
    }
    
    func getRecipes(completion: @escaping () -> Void) {
        isLoading = true
        alert = nil

        recipesRepository.fetchRecipesByComplexSearch(searchQuery: searchQuery) { result, error in

            DispatchQueue.main.async {
                if let error = error {
                    self.alert = .error(message: error)
                    print("DEBUG: \(self.alert?.message())")
                    self.isLoading = false
                    completion()
                    return
                }

                guard let result = result else { return }
                self.recipesList = result.results
                self.isLoading = false
                print(self.recipesList)
                completion()
            }
        }
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
}

