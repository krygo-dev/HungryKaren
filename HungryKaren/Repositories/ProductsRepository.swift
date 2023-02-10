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
    
    func getCartItems(completion: @escaping ([CartItem]) -> Void) {
        
        fbFirestore
            .collection(usersPath)
            .document(currentUser!)
            .collection(cartPath)
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
}
