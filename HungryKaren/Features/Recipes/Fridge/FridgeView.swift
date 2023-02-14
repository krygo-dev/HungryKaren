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
    @State var showDialog: Bool = false
    @State var ingredientName: String = ""
    @State var quantity: String = ""
    @State var isSpice: Bool = false
    
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
//            .alert(Text("Info"), isPresented: $showDialog) {
//                HKAlertView(alertType: .info(message: "Provide quantity and category"), quantity: $quantity, isSpice: $isSpice) {
//                    let product = FridgeProduct(name: ingredientName.lowercased(), quantity: quantity.lowercased(), isSpice: isSpice)
//                    fridgeViewModel.addProduct(product: product)
//                    fridgeViewModel.searchText = ""
//                    searchFieldFocused = false
//                }
//            }
            
            if searchFieldFocused && !fridgeViewModel.searchText.isEmpty {
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        if !fridgeViewModel.foundIngredientsList.isEmpty {
                            ForEach(fridgeViewModel.foundIngredientsList) { ingredient in
                                HKFoundIngredientListItemView(ingredient: ingredient) {
                                    ingredientName = ingredient.name
                                    showDialog.toggle()
                                }
                            }
                        }
                    }
                }
                .frame(width: 390, height: 500, alignment: .bottom)
                .background(.white)
                .cornerRadius(25)
            }
            
            if showDialog {
                HKAlertView(alertType: .info(message: "Provide quantity and category"), quantity: $quantity, isSpice: $isSpice) {
                    let product = FridgeProduct(name: ingredientName.lowercased(), quantity: quantity.lowercased(), isSpice: isSpice)
                    fridgeViewModel.addProduct(product: product)
                    fridgeViewModel.searchText = ""
                    searchFieldFocused = false
                }
            }
        }
    }
}

//struct FridgeView_Previews: PreviewProvider {
//    static var previews: some View {
//        FridgeView()
//            .environmentObject(FridgeViewModel())
//    }
//}
