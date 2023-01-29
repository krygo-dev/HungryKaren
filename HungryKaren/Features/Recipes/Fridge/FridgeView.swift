//
//  FridgeView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct FridgeView: View {
    var body: some View {
        ZStack {
            HKMainBackgroundCanvasView(color: alternateTertiaryColor)
            VStack {
                VStack {
                    Text("Fridge")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FridgeView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeView()
    }
}
