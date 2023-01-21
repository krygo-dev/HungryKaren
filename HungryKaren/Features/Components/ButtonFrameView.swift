//
//  ButtonFrameView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct ButtonFrameView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .fontWeight(.medium)
            .font(.system(size: 21))
            .foregroundColor(titleColor)
            .frame(width: 201, height: 58)
            .background(secondaryColor)
            .cornerRadius(25)
    }
}

struct ButtonFrameView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonFrameView(text: "Register")
    }
}
