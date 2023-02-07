//
//  SearchFiltersView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 31/01/2023.
//

import SwiftUI

struct SearchFiltersView: View {
    
    @Binding var showFilters: Bool
    @ObservedObject var searchFilters: SearchFilters
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                Group {
                    Text("Diet")
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.dietFilters[0])
                        HKSearchFilterCheckBoxView(filter: $searchFilters.dietFilters[1])
                    }
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.dietFilters[2])
                        HKSearchFilterCheckBoxView(filter: $searchFilters.dietFilters[3])
                    }
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.dietFilters[4])
                        HKSearchFilterCheckBoxView(filter: $searchFilters.dietFilters[5])
                    }
                }
                
                Rectangle()
                    .frame(width: 316, height: 1)
                    .foregroundColor(secondaryColor)
                    .padding(.vertical)
                
                Group {
                    Text("Meal type")
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.mealTypeFilters[0], bgColor: primaryColor)
                        HKSearchFilterCheckBoxView(filter: $searchFilters.mealTypeFilters[1], bgColor: primaryColor)
                    }
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.mealTypeFilters[2], bgColor: primaryColor)
                        HKSearchFilterCheckBoxView(filter: $searchFilters.mealTypeFilters[3], bgColor: primaryColor)
                    }
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.mealTypeFilters[4], bgColor: primaryColor)
                        HKSearchFilterCheckBoxView(filter: $searchFilters.mealTypeFilters[5], bgColor: primaryColor)
                    }
                }
                
                Rectangle()
                    .frame(width: 316, height: 1)
                    .foregroundColor(secondaryColor)
                    .padding(.vertical)
                
                Group {
                    Text("Cuisine")
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.cuisineFilters[0])
                        HKSearchFilterCheckBoxView(filter: $searchFilters.cuisineFilters[1])
                    }
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.cuisineFilters[2])
                        HKSearchFilterCheckBoxView(filter: $searchFilters.cuisineFilters[3])
                    }
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.cuisineFilters[4])
                        HKSearchFilterCheckBoxView(filter: $searchFilters.cuisineFilters[5])
                    }
                }
                
                Rectangle()
                    .frame(width: 316, height: 1)
                    .foregroundColor(secondaryColor)
                    .padding(.vertical)
                
                Group {
                    Text("Intolerance")
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.intoleranceFilters[0], bgColor: primaryColor)
                        HKSearchFilterCheckBoxView(filter: $searchFilters.intoleranceFilters[1], bgColor: primaryColor)
                    }
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.intoleranceFilters[2], bgColor: primaryColor)
                        HKSearchFilterCheckBoxView(filter: $searchFilters.intoleranceFilters[3], bgColor: primaryColor)
                    }
                    HStack(spacing: 30) {
                        HKSearchFilterCheckBoxView(filter: $searchFilters.intoleranceFilters[4], bgColor: primaryColor)
                        HKSearchFilterCheckBoxView(filter: $searchFilters.intoleranceFilters[5], bgColor: primaryColor)
                    }
                }
            }
        }
        .padding(.vertical, 33)
        .frame(width: 390, height: 756, alignment: .bottom)
        .background(.white)
        .cornerRadius(25)
        .ignoresSafeArea()
        .overlay {
            RoundedRectangle(cornerRadius: 25)
                .stroke(tertiaryColor, lineWidth: 5)
        }
    }
}

struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFiltersView(showFilters: .constant(true), searchFilters: SearchFilters())
    }
}
