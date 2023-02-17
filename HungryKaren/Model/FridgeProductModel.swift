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
