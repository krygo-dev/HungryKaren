//
//  HKAddItemToCartRowView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 09/02/2023.
//

import SwiftUI

struct HKAddItemToCartRowView: View {
    
    @Binding var itemName: String
    var buttonAction: () -> Void
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(tertiaryColor, lineWidth: 4)
                    .frame(width: 200, alignment: .leading)
                    .background(quaternaryColor)
                    .cornerRadius(40)
                
                TextField("", text: $itemName, prompt: Text("add product").foregroundColor(mainTextColor))
                    .padding(.horizontal, 16)
                    .font(.system(size: 18))
            }
            Spacer()
            ZStack {
                Circle()
                    .stroke(tertiaryColor, lineWidth: 4)
                    .frame(width: 31)
                    .background(quaternaryColor)
                    .cornerRadius(50)
                
                Button {
                    withAnimation {
                        buttonAction()
                    }
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 22, height: 22)
                        .tint(thirdTitleColor)
                }
            }
            .padding(.trailing, 17)
        }
        .frame(height: 37)
        .foregroundColor(mainTextColor)
        .fontWeight(.medium)
        .padding(.bottom, 17)
    }
}
