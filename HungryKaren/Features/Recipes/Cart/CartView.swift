//
//  CartView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartViewModel: CartViewModel
    @State var itemName: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    HKAddItemToCartRowView(itemName: $itemName) {
                        if !itemName.isEmpty {
                            cartViewModel.addItem(item: CartItem(name: itemName.lowercased(), isChecked: false))
                            itemName = ""
                        }
                    }
                    
                    if !cartViewModel.cartItemList.isEmpty {
                        ForEach(Array(cartViewModel.cartItemList.enumerated()), id: \.element) { index, item in
                            HKCartItemRowView(
                                cartItem: $cartViewModel.cartItemList[cartViewModel.cartItemList.firstIndex(of: item)!],
                                bgColor: index % 2 == 0 ? primaryColor : quaternaryColor) {
                                    cartViewModel.deleteItem(item: item)
                                } onTap: { cartItem in
                                    cartViewModel.updateItem(item: cartItem)
                                }
                        }
                    }
                }
                .padding(.horizontal, 17)
                .animation(.easeIn(duration: 0.3), value: cartViewModel.cartItemList)
            }
            .padding(.vertical, 20)
            .frame(width: 316, height: 548)
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(mainTextColor, lineWidth: 2)
            }
            Spacer()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartViewModel())
    }
}
