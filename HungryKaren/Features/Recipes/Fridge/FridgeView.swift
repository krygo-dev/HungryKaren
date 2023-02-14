//
//  FridgeView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct FridgeView: View {
    
    @EnvironmentObject var fridgeViewModel: FridgeViewModel
    
    @FocusState var searchFieldFocused: Bool
    @State var showProducts: Bool = false
    @State var showSpices: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        HKFridgeCategoryRowView(showList: $showProducts, title: "products")
                        
                        if showProducts {
                            ForEach(Array(fridgeViewModel.productsList.enumerated()), id: \.element) { index, product in
                                HKFridgeProductRowView(product: product, bgColor: index % 2 == 0 ? alternateSecondaryColor : alternatePrimaryColor)
                            }
                        }
                        
                        HKFridgeCategoryRowView(showList: $showSpices, title: "spices")
                        
                        if showSpices {
                            ForEach(Array(fridgeViewModel.spicesList.enumerated()), id: \.element) { index, product in
                                HKFridgeProductRowView(product: product, bgColor: index % 2 == 0 ? alternateSecondaryColor : alternatePrimaryColor)
                            }
                        }
                    }
                    .padding(.horizontal, 17)
                }
                .padding(.vertical, 20)
                .frame(width: 316, height: 548)
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(mainTextColor, lineWidth: 2)
                }
                Spacer()
            }
            
//            if !fridgeViewModel.searchText.isEmpty {
//                VStack {
//                    ScrollView(.vertical, showsIndicators: false) {
//                        if !fridgeViewModel.foundIngredientsList.isEmpty {
//                            ForEach(fridgeViewModel.foundIngredientsList) { ingredient in
//                                HKFoundIngredientListItemView(ingredient: ingredient) {
//                                    fridgeViewModel.product.name = ingredient.name
//                                    fridgeViewModel.showAddQuantityDialog.toggle()
//                                }
//                            }
//                        }
//                    }
//                }
//                .frame(width: 390, height: 500, alignment: .bottom)
//                .background(.white)
//                .cornerRadius(25)
//            }
        }
    }
}

//struct FridgeView_Previews: PreviewProvider {
//    static var previews: some View {
//        FridgeView()
//            .environmentObject(FridgeViewModel())
//    }
//}
