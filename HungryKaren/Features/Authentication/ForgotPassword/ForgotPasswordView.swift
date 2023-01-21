//
//  ForgotPasswordView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State var email: String = ""
    
    var body: some View {
        ZStack {
            HKBackgroundCanvasView(
                color: tertiaryColor,
                strokeWidth: 3,
                smallCircleRadius: 96,
                bigCircleRadius: 138,
                arcRadius: 118
            )
            HKBackgroundRoundRectView()
            VStack {
                Spacer().frame(height: 92)
                Text("Forgot password")
                    .foregroundColor(titleColor)
                    .fontWeight(.medium)
                    .font(.system(size: 30))
                Spacer().frame(height: 98)
                HKTextFieldView(
                    text: $email,
                    placeholder: "your e-mail",
                    fieldWidth: 254,
                    fieldHeight: 58
                )
                Spacer().frame(height: 29)
                Button {
                    print("Submit sign un")
                } label: {
                    Text("send")
                        .fontWeight(.medium)
                        .font(.system(size: 16))
                        .foregroundColor(mainTextColor)
                }
                Spacer().frame(height: 177)
            }
            .frame(width: 316, height: 510)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
