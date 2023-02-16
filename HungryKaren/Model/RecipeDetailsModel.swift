//
//  RecipeDetailsModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 16/02/2023.
//

import Foundation

struct RecipeDetails: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let servings: Int
    let readyInMinutes: Int
    let sourceName: String
    let sourceUrl: String
    let summary: String
}

struct RandomRecipesResult: Codable {
    let recipes: [RecipeDetails]
}
