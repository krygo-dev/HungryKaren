//
//  HKTextFieldView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct HKTextFieldView: View {
    
    @Binding var text: String
    let placeholder: String
    var fontSize: CGFloat = 21
    var placeholderColor: Color = mainTextColor
    var textColor: Color = thirdTitleColor
    var fieldWidth: CGFloat = 201
    var fieldHeight: CGFloat = 41
    
    var body: some View {
        TextField("", text: $text, prompt: Text(placeholder).foregroundColor(placeholderColor))
            .fontWeight(.medium)
            .font(.system(size: fontSize))
            .lineLimit(1)
            .multilineTextAlignment(.center)
            .foregroundColor(textColor)
            .frame(width: fieldWidth, height: fieldHeight)
            .background(secondaryColor)
            .cornerRadius(25)
    }
}
