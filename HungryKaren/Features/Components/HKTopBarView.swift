//
//  HKTopBarView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 29/01/2023.
//

import SwiftUI

struct HKTopBarView: View {
    
    let title: String
    @Binding var showMenu: Bool
    @Binding var showTopBar: Bool
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.system(size: 24))
            HStack {
                Spacer()
                Button {
                    showMenu.toggle()
                    print("Show menu")
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .frame(width: .infinity, height: 30)
        .foregroundColor(thirdTitleColor)
        .fontWeight(.medium)
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .offset(y: showTopBar ? 0 : -30)
    }
}
