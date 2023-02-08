//
//  HKFridgeCategoryRowView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 08/02/2023.
//

import SwiftUI

struct HKFridgeCategoryRowView: View {
    
    @Binding var showList: Bool
    let title: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 13, height: 13)
                .rotationEffect(showList ? .degrees(90) : .zero)
            Text(title)
                .fontWeight(.medium)
                .font(.system(size: 13))
            Spacer()
        }
        .foregroundColor(mainTextColor)
        .onTapGesture {
            withAnimation {
                showList.toggle()
            }
        }
    }
}
