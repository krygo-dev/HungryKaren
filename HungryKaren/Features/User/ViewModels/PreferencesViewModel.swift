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
    
    private func convertUserPreferences() {
        if currentUser?.preferences["cuisine"] != "" {
            searchFilters.cuisineFilters[
                searchFilters.cuisineFilters.firstIndex(
                    where: { $0.name == currentUser?.preferences["cuisine"] }
                )!
            ].isSelected = true
        }
        
        if currentUser?.preferences["diet"] != "" {
            searchFilters.dietFilters[
                searchFilters.dietFilters.firstIndex(
                    where: { $0.name == currentUser?.preferences["diet"] }
                )!
            ].isSelected = true
        }
        
        if currentUser?.preferences["intolerance"] != "" {
            searchFilters.intoleranceFilters[
                searchFilters.intoleranceFilters.firstIndex(
                    where: { $0.name == currentUser?.preferences["intolerance"] }
                )!
            ].isSelected = true
        }
        
        if currentUser?.preferences["mealType"] != "" {
            searchFilters.mealTypeFilters[
                searchFilters.mealTypeFilters.firstIndex(
                    where: { $0.name == currentUser?.preferences["mealType"] }
                )!
            ].isSelected = true
        }
    }
    
    
    func saveData() {
        
        currentUser?.preferences["cuisine"] = searchFilters.cuisineFilters.first(where: { $0.isSelected == true })?.name ?? ""
        currentUser?.preferences["diet"] = searchFilters.dietFilters.first(where: { $0.isSelected == true })?.name ?? ""
        currentUser?.preferences["intolerance"] = searchFilters.intoleranceFilters.first(where: { $0.isSelected == true })?.name ?? ""
        currentUser?.preferences["mealType"] = searchFilters.mealTypeFilters.first(where: { $0.isSelected == true })?.name ?? ""
        
        userRepository.saveUserData(user: currentUser!) {
            print("DEBUG: Data saved")
        }
    }
}
