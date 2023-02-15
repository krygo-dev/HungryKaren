//
//  QueryModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 07/02/2023.
//

struct Query {
    var query: String
//    var diet: String
//    var cuisine: String
//    var intolerance: String
//    var mealType: String
    var searchFilters: SearchFilters
}

//let queryExample = Query(query: "rice", diet: "vegetarian", cuisine: "", intolerance: "", mealType: "")
let queryExample = Query(query: "rice", searchFilters: SearchFilters())
