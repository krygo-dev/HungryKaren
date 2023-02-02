//
//  FridgeView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct FridgeView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Fridge")
            }
            .padding(.vertical, 40)
            .frame(width: 316, height: 548)
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.black, lineWidth: 1)
            }
            Spacer()
        }
    }
}

struct FridgeView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeView()
    }
}
