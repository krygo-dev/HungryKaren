//
//  ProductModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 08/02/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Product: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var name: String
    var quantity: String
    var isSpice: Bool
}

var sampleProducts: [Product] = [
    Product(name: "cheese", quantity: "200g", isSpice: false),
    Product(name: "milk", quantity: "2L", isSpice: false),
    Product(name: "eggs", quantity: "10", isSpice: false),
    Product(name: "apples", quantity: "1kg", isSpice: false),
    Product(name: "sugar", quantity: "2kg", isSpice: false),
    Product(name: "flour", quantity: "1kg", isSpice: false),
    Product(name: "potatos", quantity: "500g", isSpice: false),
]
