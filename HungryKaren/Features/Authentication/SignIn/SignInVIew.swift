//
//  SignInVIew.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct SignInVIew: View {
    
    @State var login: String = ""
    @State var password: String = ""
    
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
                Spacer().frame(height: 47)
                Text("Sign In")
                    .foregroundColor(titleColor)
                    .fontWeight(.medium)
                    .font(.system(size: 30))
                Spacer().frame(height: 98)
                Group {
                    HKTextFieldView(
                        text: $login,
                        placeholder: "login",
                        fieldHeight: 58
                    )
                    Spacer().frame(height: 32)
                    HKTextFieldView(
                        text: $password,
                        placeholder: "password",
                        fieldHeight: 58
                    )

                }
                Spacer().frame(height: 6)
                Button {
                    print("Forgot pass")
                } label: {
                    Text("forgot password")
                        .fontWeight(.medium)
                        .font(.system(size: 12))
                        .foregroundColor(mainTextColor)
                }
                Spacer().frame(height: 29)
                Button {
                    print("Submit sign in")
                } label: {
                    Text("okay")
                        .fontWeight(.medium)
                        .font(.system(size: 16))
                        .foregroundColor(mainTextColor)
                }
                Spacer().frame(height: 111)
            }
            .frame(width: 316, height: 510)
        }
    }
}

struct SignInVIew_Previews: PreviewProvider {
    static var previews: some View {
        SignInVIew()
    }
}
