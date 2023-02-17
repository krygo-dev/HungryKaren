//
//  ProductsRepository.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 09/02/2023.
//

import Firebase
import FirebaseFirestoreSwift

final class ProductsRepository {
    
    private let fbFirestore = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser?.uid
    private let searchIngredientsUrl = "https://api.spoonacular.com/food/ingredients/search?query="
    
    
    func getCartItems(completion: @escaping ([CartItem]) -> Void) {
        
        fbFirestore
            .collection(usersPath)
            .document(currentUser!)
            .collection(cartPath)
            .order(by: "isChecked", descending: false)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                completion(
                    snapshot?.documents.compactMap {
                        try? $0.data(as: CartItem.self)
                    } ?? []
                )
            }
    }
    
    
    func addItemToCart(item: CartItem) {
        do {
            _ = try fbFirestore
                .collection(usersPath)
                .document(currentUser!)
                .collection(cartPath)
                .addDocument(from: item)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
    
    func deleteCartItem(item: CartItem) {
        fbFirestore
            .collection(usersPath)
            .document(currentUser!)
            .collection(cartPath)
            .document(item.id!)
            .delete()
    }
    
    
    func updateCartItem(item: CartItem) {
        do {
            _ = try fbFirestore
                .collection(usersPath)
                .document(currentUser!)
                .collection(cartPath)
                .document(item.id!)
                .setData(from: item)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
    func getProductsInFridge(completion: @escaping ([FridgeProduct]) -> Void) {
        fbFirestore
            .collection(usersPath)
            .document(currentUser!)
            .collection(fridgePath)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                completion(
                    snapshot?.documents.compactMap {
                        try? $0.data(as: FridgeProduct.self)
                    } ?? []
                )
            }
    }
    
    
    func addProductToFridge(product: FridgeProduct) {
        do {
            _ = try fbFirestore
                .collection(usersPath)
                .document(currentUser!)
                .collection(fridgePath)
                .addDocument(from: product)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
    
    func deleteProductFromFridge(product: FridgeProduct) {
        fbFirestore
            .collection(usersPath)
            .document(currentUser!)
            .collection(fridgePath)
            .document(product.id!)
            .delete()
    }
    
    
    func searchForIngredients(query: String, completion: @escaping (IngredientsResult?, String?) -> Void) {
        
        guard let url = URL(string: searchIngredientsUrl + "\(query)&number=10&apiKey=\(spoonacularApiKey)") else {
            completion(nil, unexpectedError)
            return
        }
        
        URLSession
            .shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(nil, error.localizedDescription)
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(nil, badStatusCodeError)
                }else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(IngredientsResult.self, from: data)
                        completion(result, nil)
                    } catch {
                        completion(nil, error.localizedDescription)
                    }
                }
            }
            .resume()
    }
}
