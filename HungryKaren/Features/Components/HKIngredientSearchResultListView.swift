//
//  HKIngredientSearchResultListView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 14/02/2023.
//

import SwiftUI

struct HKIngredientSearchResultListView: View {
    
    @EnvironmentObject var fridgeViewModel: FridgeViewModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    if !fridgeViewModel.foundIngredientsList.isEmpty {
                        ForEach(fridgeViewModel.foundIngredientsList) { ingredient in
                            HKFoundIngredientListItemView(ingredient: ingredient) {
                                fridgeViewModel.product.name = ingredient.name
                                fridgeViewModel.showAddQuantityDialog.toggle()
                            }
                        }
                    }
                }
            }
            .padding(.top, 30)
            .frame(width: 400, height: 550, alignment: .bottom)
            .background(.white)
            .padding(.bottom, 20)
            .cornerRadius(25)
            .padding(.bottom, -20)
            .offset(y: !fridgeViewModel.searchText.isEmpty ? 0 : 550)
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .background(!fridgeViewModel.searchText.isEmpty ? .black.opacity(0.35) : .clear)
        .offset(y: -128)
    }
}
