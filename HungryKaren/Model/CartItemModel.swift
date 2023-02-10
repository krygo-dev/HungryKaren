//
//  CartItemModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 09/02/2023.
//

import FirebaseFirestoreSwift

struct CartItem: Identifiable, Hashable, Equatable, Codable {
    @DocumentID var id: String?
    var name: String
    var isChecked: Bool
}
