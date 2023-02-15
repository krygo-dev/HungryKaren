//
//  UserModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 06/02/2023.
//

struct User: Codable, Hashable {
    let uid: String
    let email: String
    let name: String
    var preferences: [String : String]
}
