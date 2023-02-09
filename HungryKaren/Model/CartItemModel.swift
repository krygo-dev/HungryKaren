//
//  CartItemModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 09/02/2023.
//

import Foundation

struct CartItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var isChecked: Bool = false
}

let sampleCartItems = [
    CartItem(name: "cheese"),
    CartItem(name: "milk"),
    CartItem(name: "eggs"),
    CartItem(name: "flour"),
    CartItem(name: "sugar"),
    CartItem(name: "honey")
]
