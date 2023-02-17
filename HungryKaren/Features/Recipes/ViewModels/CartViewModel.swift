//
//  CartViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 09/02/2023.
//

import SwiftUI

final class CartViewModel: ObservableObject {
    
    private let productsRepository = ProductsRepository()
    
    @Published var cartItemList: [CartItem] = []
    @Published var filteredList: [CartItem] = []
    @Published var searchText: String = "" {
        didSet {
            search()
        }
    }
    
    
    init() {
        productsRepository.getCartItems { cartItems in
            self.cartItemList = cartItems
            self.filteredList = self.cartItemList
        }
    }
    
    
    func addItem(item: CartItem) {
        productsRepository.addItemToCart(item: item)
    }
    
    
    func deleteItem(item: CartItem) {
        productsRepository.deleteCartItem(item: item)
    }
    
    
    func updateItem(item: CartItem) {
        productsRepository.updateCartItem(item: item)
    }
    
    
    private func search() {
        filteredList = searchText.isEmpty ? cartItemList : cartItemList.filter({ $0.name.contains(searchText.lowercased()) })
    }
}
