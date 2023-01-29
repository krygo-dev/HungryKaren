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
                        .frame(width: 27, height: 27)
                }
            }
        }
        .frame(width: .infinity, height: 30)
        .foregroundColor(thirdTitleColor)
        .fontWeight(.medium)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

//struct HKTopBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        HKTopBarView()
//    }
//}
