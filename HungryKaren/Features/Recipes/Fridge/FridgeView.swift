//
//  FridgeView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct FridgeView: View {
    
    @State var showMenu: Bool = false
    
    var body: some View {
        ZStack {
            HKMainBackgroundCanvasView(color: alternateTertiaryColor)
            VStack {
                VStack {
                    HKTopBarView(title: "Fridge", showMenu: $showMenu)
                    
                    Spacer()
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
