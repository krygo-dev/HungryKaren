//
//  IngredientsResultModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 13/02/2023.
//

import Foundation

struct IngredientsResult: Codable {
    var results: [Ingredient]
    var offset: Int
    var number: Int
    var totalResults: Int
}


struct Ingredient: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var image: String
}
