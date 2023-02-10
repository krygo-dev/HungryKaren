//
//  FridgeViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 10/02/2023.
//

import SwiftUI

final class FridgeViewModel: ObservableObject {
    
    private let productRepository: ProductsRepository = ProductsRepository()
    
    @Published var productsList: [Product] = []
    @Published var spicesList: [Product] = []
    
    init() {
        productRepository.getProductsInFridge { list in
            self.productsList = list.filter { $0.isSpice == false }
            self.spicesList = list.filter { $0.isSpice == true }
        }
    }
    
    
    func addProduct(product: Product) {
        productRepository.addProductToFridge(product: product)
    }
}
