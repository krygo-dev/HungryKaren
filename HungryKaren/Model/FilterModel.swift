//
//  FilterModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 01/02/2023.
//

struct Filter {
    let name: String
    var isSelected: Bool
}

let dietList = [
    Filter(name: "vegan", isSelected: false),
    Filter(name: "vegetarian", isSelected: false),
    Filter(name: "gluten free", isSelected: false),
    Filter(name: "lacto-free", isSelected: false),
    Filter(name: "keto", isSelected: false),
    Filter(name: "paleo", isSelected: false),
]

let mealTypeList = [
    Filter(name: "breakfast", isSelected: false),
    Filter(name: "main course", isSelected: false),
    Filter(name: "salad", isSelected: false),
    Filter(name: "dessert", isSelected: false),
    Filter(name: "soup", isSelected: false),
    Filter(name: "beverage", isSelected: false),
]

let intoleranceList = [
    Filter(name: "dairy", isSelected: false),
    Filter(name: "gluten", isSelected: false),
    Filter(name: "peanut", isSelected: false),
    Filter(name: "soy", isSelected: false),
    Filter(name: "seafood", isSelected: false),
    Filter(name: "grain", isSelected: false),
]

let cuisineList = [
    Filter(name: "italian", isSelected: false),
    Filter(name: "greek", isSelected: false),
    Filter(name: "mexican", isSelected: false),
    Filter(name: "thai", isSelected: false),
    Filter(name: "chinese", isSelected: false),
    Filter(name: "indian", isSelected: false),
]
