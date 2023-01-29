//
//  CartView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct CartView: View {
    
    @State var showMenu: Bool = false
    
    var body: some View {
        ZStack {
            HKMainBackgroundCanvasView(color: tertiaryColor)
            VStack {
                HKTopBarView(title: "Cart", showMenu: $showMenu)
                
                Spacer()
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
