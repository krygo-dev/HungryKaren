//
//  HomeViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 06/02/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    private let recipesRepository = RecipesRespository()
    
    @Published private(set) var recipesList: [Recipe] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var alert: AlertType? = nil
    
    init() {
        getRecipes {
            print("Data fetched")
        }
    }
    
    func getRecipes(completion: @escaping () -> Void) {
        isLoading = true
        alert = nil
        
        recipesRepository.recipesComplexSearch(searchQuery: queryExample) { result, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    self.alert = .error(message: error)
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
}

