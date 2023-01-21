//
//  SignInVIew.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct SignInVIew: View {
    var body: some View {
        ZStack {
            BackgroundCanvasView(
                color: tertiaryColor,
                strokeWidth: 3,
                smallCircleRadius: 96,
                bigCircleRadius: 138,
                arcRadius: 118
            )
            BackgroundRoundRectView()
            VStack {
                Text("Sign In")
                    .foregroundColor(titleColor)
                    .fontWeight(.medium)
                    .font(.system(size: 30))
            }
        }
    }
}

struct SignInVIew_Previews: PreviewProvider {
    static var previews: some View {
        SignInVIew()
    }
}
