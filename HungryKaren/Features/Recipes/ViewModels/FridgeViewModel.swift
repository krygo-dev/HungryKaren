//
//  FridgeViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 10/02/2023.
//

import SwiftUI

final class FridgeViewModel: ObservableObject {
    
    private let productRepository: ProductsRepository = ProductsRepository()
    
    @Published var productsList: [FridgeProduct] = []
    @Published var spicesList: [FridgeProduct] = []
    @Published var foundIngredientsList: [Ingredient] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var alert: AlertType? = nil
    @Published var searchText: String = "" {
        didSet {
//            searchForIngredients()
        }
    }
    
    private var workItem: DispatchWorkItem?

    
    init() {
        productRepository.getProductsInFridge { list in
            self.productsList = list.filter { $0.isSpice == false }
            self.spicesList = list.filter { $0.isSpice == true }
        }
    }
    
    
    func addProduct(product: FridgeProduct) {
        productRepository.addProductToFridge(product: product)
    }
    
    
//    func searchForIngredient(query: String, completion: @escaping () -> Void) {
//        isLoading = true
//        alert = nil
//
//        productRepository.searchForIngredients(query: query) { result, error in
//
//            DispatchQueue.main.async {
//                if let error = error {
//                    self.alert = .error(message: error)
//                    self.isLoading = false
//                    completion()
//                    return
//                }
//
//                guard let result = result else { return }
//                self.foundIngredientsList = result.results
//                self.isLoading = false
//                print(self.foundIngredientsList)
//                completion()
//            }
//        }
//    }
    
    private func searchForIngredients() {
        workItem?.cancel()
        isLoading = true
        alert = nil
        
        if searchText.isEmpty { return }
        
        let item = DispatchWorkItem {
            self.productRepository.searchForIngredients(query: self.searchText) { result, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.alert = .error(message: error)
                        self.isLoading = false
                        return
                    }
                    
                    guard let result = result else { return }
                    self.foundIngredientsList = result.results
                    self.isLoading = false
                }
            }
        }
        
        workItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem!)
        return
    }
}
