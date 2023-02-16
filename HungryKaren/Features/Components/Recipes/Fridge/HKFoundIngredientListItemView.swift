//
//  HKFoundIngredientListItemView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 13/02/2023.
//

import SwiftUI

struct HKFoundIngredientListItemView: View {
    
    let ingredient: Ingredient
    var onTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 40)
                .stroke(mainTextColor, lineWidth: 4)
                .frame(width: 200, alignment: .leading)
                .background(alternatePrimaryColor)
                .cornerRadius(40)
            
            Text(ingredient.name)
                .padding(.horizontal, 16)
                .font(.system(size: 18))
        }
        .frame(height: 37)
        .foregroundColor(thirdTitleColor)
        .fontWeight(.medium)
        .padding(.bottom, 17)
        .onTapGesture {
            onTap()
        }
    }
}
