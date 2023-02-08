//
//  ProductModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 08/02/2023.
//

import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let quantity: String
}

var sampleProducts: [Product] = [
    Product(name: "cheese", quantity: "200g"),
    Product(name: "milk", quantity: "2L"),
    Product(name: "eggs", quantity: "10"),
    Product(name: "apples", quantity: "1kg"),
    Product(name: "sugar", quantity: "2kg"),
    Product(name: "flour", quantity: "1kg"),
    Product(name: "potatos", quantity: "500g"),
]
