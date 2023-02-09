//
//  CartViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 09/02/2023.
//

import SwiftUI

final class CartViewModel: ObservableObject {
    
    @Published var cartItemList: [CartItem] = []
    
    func addItem(item: CartItem) {
        cartItemList.append(item)
    }
    
    func deleteItem(item: CartItem) {
        cartItemList.removeAll(where: { item == $0 })
    }
}
