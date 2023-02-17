//
//  RecipesRepository.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 06/02/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class RecipesRespository {
    
    private let fbFirestore = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser?.uid
    
    private let searchRecipesComplexSearchUrl = "https://api.spoonacular.com/recipes/complexSearch?"
    private let searchRecipesByIngredientsUrl = "https://api.spoonacular.com/recipes/findByIngredients?ingredients="
    private let getRandomRecipesUrl = "https://api.spoonacular.com/recipes/random?"
    private let getRecipesInformationBulkUrl = "https://api.spoonacular.com/recipes/informationBulk?"
    
    
    func fetchRecipesByComplexSearch(searchQuery: Query, completion: @escaping (RecipesResults?, String?) -> Void) {
        
        var cuisine = ""
        searchQuery.searchFilters.cuisineFilters.forEach { filter in
            cuisine += filter.isSelected ? "\(filter.name)," : ""
        }
        if cuisine.last == "," { cuisine.removeLast(1) }
        
        var diet = ""
        searchQuery.searchFilters.dietFilters.forEach { filter in
            diet += filter.isSelected ? "\(filter.name)," : ""
        }
        if diet.last == "," { diet.removeLast(1) }
        
        var intolerance = ""
        searchQuery.searchFilters.intoleranceFilters.forEach { filter in
            intolerance += filter.isSelected ? "\(filter.name)," : ""
        }
        if intolerance.last == ","  { intolerance.removeLast(1) }
        
        var mealType = ""
        searchQuery.searchFilters.mealTypeFilters.forEach { filter in
            mealType += filter.isSelected ? "\(filter.name)," : ""
        }
        if mealType.last == "," { mealType.removeLast(1) }
        
        var urlStr = searchRecipesComplexSearchUrl +
                    "query=\(searchQuery.query)" +
                    "\(diet.count > 0 ? "&diet=\(diet)" : "")" +
                    "\(cuisine.count > 0 ? "&cuisine=\(cuisine)" : "")" +
                    "\(intolerance.count > 0 ? "&intolerance=\(intolerance)" : "")" +
                    "\(mealType.count > 0 ? "&type=\(mealType)" : "")" +
                    "&number=15&apiKey=\(spoonacularApiKey)"
        
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
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
        
        if ingredientsString.last == "+" { ingredientsString.removeLast(2) }
        ingredientsString = ingredientsString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
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

    
    func getRandomRecipes(completion: @escaping ([RecipeDetails]?, String?) -> Void) {
        
        let urlStr = getRandomRecipesUrl + "number=10&apiKey=\(spoonacularApiKey)"
        
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
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(RandomRecipesResult.self, from: data)
                        completion(result.recipes, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                }
            }
            .resume()
    }
    
    
    func getRecipesDetailsBulk(recipesIds: [Int], completion: @escaping ([RecipeDetails]?, String?) -> Void) {
        
        var recipesIdsStr = ""
        recipesIds.forEach { id in
            recipesIdsStr += "\(id),"
        }
        if recipesIdsStr.last == "," { recipesIdsStr.removeLast(1) }
        
        let urlStr = getRecipesInformationBulkUrl + "ids=\(recipesIdsStr)&apiKey=\(spoonacularApiKey)"
        
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
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode([RecipeDetails].self, from: data)
                        completion(result, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                }
            }
            .resume()
    }
    
    
    func getFavouritesRecipes(completion: @escaping ([RecipeDetailsFirebase]) -> Void) {
        fbFirestore
            .collection(usersPath)
            .document(currentUser!)
            .collection(favouritesPath)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                completion(
                    snapshot?.documents.compactMap {
                        try? $0.data(as: RecipeDetailsFirebase.self)
                    } ?? []
                )
            }
    }
    
    
    func addRecipeToFavourites(recipe: RecipeDetails) {
        do {
            _ = try fbFirestore
                .collection(usersPath)
                .document(currentUser!)
                .collection(favouritesPath)
                .addDocument(from: recipe)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
    
    func deleteRecipeFromFavourites(recipe: RecipeDetailsFirebase) {
        fbFirestore
            .collection(usersPath)
            .document(currentUser!)
            .collection(favouritesPath)
            .document(recipe.docId!)
            .delete()
    }
}
