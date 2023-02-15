//
//  SearchFilters.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 01/02/2023.
//

import SwiftUI

class SearchFilters: ObservableObject {
    
    @Published var dietFilters: [Filter] = dietList
    @Published var intoleranceFilters: [Filter] = intoleranceList
    @Published var cuisineFilters: [Filter] = cuisineList
    @Published var mealTypeFilters: [Filter] = mealTypeList

}
