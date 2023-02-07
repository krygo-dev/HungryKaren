//
//  RecipeModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 07/02/2023.
//

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}


struct RecipesResults: Codable {
    let offset: Int
    let number: Int
    let totalResults: Int
    let results: [Recipe]
}
