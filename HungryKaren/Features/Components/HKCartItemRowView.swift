//
//  HKCartItemRowView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 09/02/2023.
//

import SwiftUI

struct HKCartItemRowView: View {
    
    @Binding var cartItem: CartItem
    let bgColor: Color
    let onLongPress: () -> Void
    let onTap: (CartItem) -> Void
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(tertiaryColor, lineWidth: 4)
                    .frame(width: 200, alignment: .leading)
                    .background(bgColor)
                    .cornerRadius(40)
                    .shadow(color: cartItem.isChecked ? .gray : .clear, radius: 4, y: 4)
                
                Text(cartItem.name)
                    .padding(.horizontal, 16)
                    .font(.system(size: 18))
            }
            Spacer()
            ZStack {
                Circle()
                    .stroke(tertiaryColor, lineWidth: 4)
                    .frame(width: 31)
                    .background(bgColor)
                    .cornerRadius(50)
                    .shadow(color: cartItem.isChecked ? .gray : .clear, radius: 4, y: 4)
                
                if cartItem.isChecked {
                    Image(systemName: "checkmark")
                        .frame(width: 22, height: 22)
                        .tint(thirdTitleColor)
                }
                
            }
            .padding(.trailing, 17)
            .onTapGesture {
                withAnimation {
                    cartItem.isChecked.toggle()
                    onTap(cartItem)
                }
            }
        }
        .frame(height: 37)
        .foregroundColor(thirdTitleColor)
        .fontWeight(.medium)
        .padding(.bottom, 17)
        .onLongPressGesture {
            withAnimation {
                onLongPress()
            }
        }
    }
}
