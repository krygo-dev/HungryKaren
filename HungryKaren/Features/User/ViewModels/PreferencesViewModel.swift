//
//  PreferencesViewModel.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 17/02/2023.
//

import Foundation

final class PreferencesViewModel: ObservableObject {
    
    private let userRepository: UserRepository = UserRepository()
    private let authenticationRepository: AuthenticationRepository = AuthenticationRepository()
    
    @Published var currentUser: User? = nil
    @Published var searchFilters: SearchFilters = SearchFilters()
    
    init() {
        userRepository.getUserData(uid: authenticationRepository.getCurrentUser()!.uid) { user in
            self.currentUser = user
            self.convertUserPreferences()
        }
    }
    
    
    func saveData() {
        
        currentUser?.preferences[cuisine] = searchFilters.cuisineFilters.map({ return $0.isSelected == true ? $0.name : "" })
        currentUser?.preferences[diet] = searchFilters.dietFilters.map({ return $0.isSelected == true ? $0.name : "" })
        currentUser?.preferences[intolerance] = searchFilters.intoleranceFilters.map({ return $0.isSelected == true ? $0.name : "" })
        currentUser?.preferences[mealType] = searchFilters.mealTypeFilters.map({ return $0.isSelected == true ? $0.name : "" })
        
        userRepository.saveUserData(user: currentUser!) {}
    }
    
    
    private func convertUserPreferences() {
        
        currentUser?.preferences[cuisine]?.forEach { name in
            if !name.isEmpty {
                searchFilters.cuisineFilters[searchFilters.cuisineFilters.firstIndex(where: { $0.name == name })!].isSelected = true
            }
        }
        
        currentUser?.preferences[diet]?.forEach { name in
            if !name.isEmpty {
                searchFilters.dietFilters[searchFilters.dietFilters.firstIndex(where: { $0.name == name })!].isSelected = true
            }
        }
        
        currentUser?.preferences[intolerance]?.forEach { name in
            if !name.isEmpty {
                searchFilters.intoleranceFilters[searchFilters.intoleranceFilters.firstIndex(where: { $0.name == name })!].isSelected = true
            }
        }
        
        currentUser?.preferences[mealType]?.forEach { name in
            if !name.isEmpty {
                searchFilters.mealTypeFilters[searchFilters.mealTypeFilters.firstIndex(where: { $0.name == name })!].isSelected = true
            }
        }
    }
}
