//
//  HKSearchFilterCheckBoxView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 01/02/2023.
//

import SwiftUI

struct HKSearchFilterCheckBoxView: View {
    
    @Binding var filter: Filter
    var bgColor: Color = quaternaryColor
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .stroke(tertiaryColor, lineWidth: 4)
                .frame(width: 134, height: 37)
                .background(bgColor)
                .cornerRadius(40)
                .shadow(color: filter.isSelected ? .gray : .clear, radius: 4, y: 4)
            
            Text(filter.name)
                .foregroundColor(thirdTitleColor)
                .fontWeight(.medium)
                .font(.system(size: 18))
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.3)) {
                filter.isSelected.toggle()
            }
        }
    }
}
