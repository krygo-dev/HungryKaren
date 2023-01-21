//
//  SplashView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 20/01/2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            BackgroundCanvasView(
                color: secondaryColor,
                strokeWidth: 5,
                smallCircleRadius: 119,
                bigCircleRadius: 228,
                arcRadius: 135)
            
            VStack {
                Image("hungry_karen_logo")
                    .resizable()
                    .scaledToFill()
                .frame(width: 273, height: 248)
                Spacer().frame(height: 34)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
