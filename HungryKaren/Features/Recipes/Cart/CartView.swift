//
//  CartView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct CartView: View {
    
    @State var itemName: String = ""
    @State private var list = sampleCartItems
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    HKAddItemToCartRowView(itemName: $itemName) {
                        if !itemName.isEmpty {
                            list.append(CartItem(name: itemName.lowercased()))
                            itemName = ""
                        }
                    }
                    
                    ForEach(Array(list.enumerated()), id: \.element) { index, item in
                        HKCartItemRowView(cartItem: $list[index], bgColor: index % 2 == 0 ? primaryColor : quaternaryColor)
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
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
