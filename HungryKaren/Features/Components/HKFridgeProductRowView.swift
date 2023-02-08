//
//  HKFridgeProductRowView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 08/02/2023.
//

import SwiftUI

struct HKFridgeProductRowView: View {
    
    var product: Product? = nil
    let bgColor: Color
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(mainTextColor, lineWidth: 4)
                    .frame(width: 200, alignment: .leading)
                    .background(bgColor)
                    .cornerRadius(40)
                
                Text(product == nil ? "+ add product" : product!.name)
                    .padding(.horizontal, 16)
                    .font(.system(size: 18))
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(mainTextColor, lineWidth: 4)
                    .frame(width: 63)
                    .background(bgColor)
                    .cornerRadius(10)
                
                Text(product == nil ? "qty" : product!.quantity)
                    .padding(.horizontal, 8)
                    .font(.system(size: 15))
            }
        }
        .frame(height: 37)
        .foregroundColor(product == nil ? mainTextColor : thirdTitleColor)
        .fontWeight(.medium)
        .padding(.bottom, 17)
    }
}
