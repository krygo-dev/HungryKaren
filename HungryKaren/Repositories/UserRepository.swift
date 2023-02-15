//
//  UserRepository.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 06/02/2023.
//

import Firebase

class UserRepository {
    private let fbFirestore = Firestore.firestore()
    
    
    func getUserData(uid: String, comletion: @escaping (User) -> Void) {
        fbFirestore
            .collection(usersPath)
            .document(uid)
            .getDocument(as: User.self) { result in
                switch result {
                case .success(let user):
                    comletion(user)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    
    func saveUserData(user: User, completion: @escaping () -> Void) {
        do {
            _ = try fbFirestore
                .collection(usersPath)
                .document(user.uid)
                .setData(from: user) { _ in
                    completion()
                }
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}
