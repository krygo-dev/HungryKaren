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
        
        var cuisine = ""
        searchQuery.searchFilters.cuisineFilters.forEach { filter in
            cuisine += filter.isSelected ? "\(filter.name)," : ""
        }
        if cuisine.last == "," { cuisine.removeLast(1) }
        print("DEBUG: Cuisine \(cuisine)")
        
        var diet = ""
        searchQuery.searchFilters.dietFilters.forEach { filter in
            diet += filter.isSelected ? "\(filter.name)," : ""
        }
        if diet.last == "," { diet.removeLast(1) }
        print("DEBUG: Diet \(diet)")
        
        var intolerance = ""
        searchQuery.searchFilters.intoleranceFilters.forEach { filter in
            intolerance += filter.isSelected ? "\(filter.name)," : ""
        }
        if intolerance.last == ","  { intolerance.removeLast(1) }
        print("DEBUG: Into \(intolerance)")
        
        var mealType = "main course"
//        searchQuery.searchFilters.mealTypeFilters.forEach { filter in
//            mealType += filter.isSelected ? "\(filter.name)," : ""
//        }
//        if mealType.count > 0 { mealType.removeLast(1) }
        print("DEBUG: Meal \(mealType)")
        
        let urlStr = searchRecipesComplexSearchUrl +
        "query=\(searchQuery.query)" +
        "\(diet.count > 0 ? "&diet=\(diet)" : "")" +
        "\(cuisine.count > 0 ? "&cuisine=\(cuisine)" : "")" +
        "\(intolerance.count > 0 ? "&intolerance=\(intolerance)" : "")" +
        "\(mealType.count > 0 ? "&type=\(mealType)" : "")" +
        "&number=5&apiKey=\(spoonacularApiKey)"
        
        print("DEBUG: \(urlStr)")
        
        guard let url = URL(string: urlStr) else {
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


