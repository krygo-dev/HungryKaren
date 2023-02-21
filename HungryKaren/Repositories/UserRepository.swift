//
//  UserRepository.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 06/02/2023.
//

import Firebase

class UserRepository {
    
    private let fbFirestore = Firestore.firestore()
    
    
    func getUserData(uid: String, completion: @escaping (User) -> Void) {
        fbFirestore
            .collection(usersPath)
            .document(uid)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                completion(try! (snapshot?.data(as: User.self))!)
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
