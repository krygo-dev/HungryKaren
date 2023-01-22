//
//  SplashView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 20/01/2023.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var path: [Routes]
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            HKBackgroundCanvasView(
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                if authViewModel.currentUser != nil {
                    path.append(.homeView)
                } else {
                    path.append(.startView)
                }
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
