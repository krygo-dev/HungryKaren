//
//  SignUpView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @State var email: String = ""
    @State var login: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    private let fieldHeight: CGFloat = 41
    private let fontSize: CGFloat = 19
    
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
                Text("Register")
                    .foregroundColor(titleColor)
                    .fontWeight(.medium)
                    .font(.system(size: 30))
                Spacer().frame(height: 42)
                Group {
                    HKTextFieldView(
                        text: $email,
                        placeholder: "e-mail",
                        fontSize: fontSize,
                        fieldHeight: fieldHeight
                    )
                    Spacer().frame(height: 17)
                    HKTextFieldView(
                        text: $login,
                        placeholder: "login",
                        fontSize: fontSize,
                        fieldHeight: fieldHeight
                    )
                    Spacer().frame(height: 17)
                    HKTextFieldView(
                        text: $password,
                        placeholder: "password",
                        fontSize: fontSize,
                        fieldHeight: fieldHeight,
                        isSecureField: true
                    )
                    Spacer().frame(height: 17)
                    HKTextFieldView(
                        text: $confirmPassword,
                        placeholder: "confirm password",
                        fontSize: fontSize,
                        fieldHeight: fieldHeight,
                        isSecureField: true
                    )

                }
                Spacer().frame(height: 35)
                Button {
                    print("Submit sign un")
                } label: {
                    Text("okay")
                        .fontWeight(.medium)
                        .font(.system(size: 16))
                        .foregroundColor(mainTextColor)
                }
                Spacer().frame(height: 116)
            }
            .frame(width: 316, height: 510)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
