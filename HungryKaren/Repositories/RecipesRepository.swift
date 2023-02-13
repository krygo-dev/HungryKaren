//
//  RecipesRepository.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 06/02/2023.
//

import Foundation

class RecipesRespository {
    
    private let searchRecipesComplexSearchUrl = "https://api.spoonacular.com/recipes/complexSearch?"
    private let searchRecipesByIngredientsUrl = "https://api.spoonacular.com/recipes/findByIngredients?ingredients="
    
    func fetchRecipesByComplexSearch(searchQuery: Query, completion: @escaping (RecipesResults?, String?) -> Void) {
        
        guard let url = URL(string: searchRecipesComplexSearchUrl +
                            "query=\(searchQuery.query)&diet=\(searchQuery.diet)&cuisine=\(searchQuery.cuisine)&intolerance=\(searchQuery.intolerance)&mealType=\(searchQuery.mealType)&number=5&apiKey=\(spoonacularApiKey)") else {
            completion(nil, unexpectedError)
            return
        }
        
        URLSession
            .shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(nil, badStatusCodeError)
                }else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(RecipesResults.self, from: data)
                        completion(result, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                }
            }
            .resume()
    }
    
    func fetchRecipesByIngredients(ingredients: [String], completion: @escaping ([Recipe]?, String?) -> Void) {
        
        var ingredientsString = ""
        ingredients.forEach { ingredient in
            ingredientsString += "\(ingredient),+"
        }
        
        ingredientsString.removeLast(2)
        
        guard let url = URL(string: searchRecipesByIngredientsUrl + "\(ingredientsString)&number=10&apiKey=\(spoonacularApiKey)") else {
            completion(nil, unexpectedError)
            return
        }
        
        URLSession
            .shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(nil, badStatusCodeError)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode([Recipe].self, from: data)
                        completion(result, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                }
            }
            .resume()
    }
}


