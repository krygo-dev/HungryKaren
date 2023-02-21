//
//  RecipeDetailsModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 16/02/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct RecipeDetails: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let image: String
    let servings: Int
    let readyInMinutes: Int
    let healthScore: Float
    let sourceName: String
    let sourceUrl: String
    let summary: String
}

struct RandomRecipesResult: Codable {
    let recipes: [RecipeDetails]
}

struct RecipeDetailsFirebase: Codable, Identifiable, Hashable {
    @DocumentID var docId: String?
    let id: Int
    let title: String
    let image: String
    let servings: Int
    let readyInMinutes: Int
    let healthScore: Float
    let sourceName: String
    let sourceUrl: String
    let summary: String
}

extension RecipeDetails {
    init(from recipeDetailsFirebase: RecipeDetailsFirebase) {
        self.init(
            id: recipeDetailsFirebase.id,
            title: recipeDetailsFirebase.title,
            image: recipeDetailsFirebase.image,
            servings: recipeDetailsFirebase.servings,
            readyInMinutes: recipeDetailsFirebase.readyInMinutes,
            healthScore: recipeDetailsFirebase.healthScore,
            sourceName: recipeDetailsFirebase.sourceName,
            sourceUrl: recipeDetailsFirebase.sourceUrl,
            summary: recipeDetailsFirebase.summary)
    }
}

let sampleRecipeDetail = RecipeDetails(
    id: 716429,
    title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
    image: "https://spoonacular.com/recipeImages/716429-556x370.jpg",
    servings: 2,
    readyInMinutes: 45,
    healthScore: 19.0,
    sourceName: "Full Belly Sisters",
    sourceUrl: "http://fullbellysisters.blogspot.com/2012/06/pasta-with-garlic-scallions-cauliflower.html",
    summary: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire."
)
