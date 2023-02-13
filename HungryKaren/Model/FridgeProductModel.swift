//
//  FridgeProductModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 08/02/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct FridgeProduct: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var name: String
    var quantity: String
    var isSpice: Bool
}

//var sampleProducts: [FridgeProduct] = [
//    FridgeProduct(name: "cheese", quantity: "200g", isSpice: false),
//    FridgeProduct(name: "milk", quantity: "2L", isSpice: false),
//    FridgeProduct(name: "eggs", quantity: "10", isSpice: false),
//    FridgeProduct(name: "apples", quantity: "1kg", isSpice: false),
//    FridgeProduct(name: "sugar", quantity: "2kg", isSpice: false),
//    FridgeProduct(name: "flour", quantity: "1kg", isSpice: false),
//    FridgeProduct(name: "potatos", quantity: "500g", isSpice: false),
//]
