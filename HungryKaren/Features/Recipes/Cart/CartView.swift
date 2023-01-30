//
//  CartView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct CartView: View {
        var body: some View {
        ZStack {
//            HKMainBackgroundCanvasView(color: tertiaryColor)
            VStack {
                Text("Cart")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
