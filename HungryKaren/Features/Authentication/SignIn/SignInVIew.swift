//
//  SignInVIew.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct SignInVIew: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Binding var path: [Routes]
    @State var email: String = ""
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
                        text: $email,
                        placeholder: "e-mail",
                        fieldHeight: 58
                    )
                    Spacer().frame(height: 32)
                    HKTextFieldView(
                        text: $password,
                        placeholder: "password",
                        fieldHeight: 58,
                        isSecureField: true
                    )

                }
                Spacer().frame(height: 6)
                NavigationLink(value: Routes.forgotPasswordView) {
                    Text("forgot password")
                        .fontWeight(.medium)
                        .font(.system(size: 12))
                        .foregroundColor(mainTextColor)
                }
                Spacer().frame(height: 29)
                Button {
                    authViewModel.signInWithEmailAndPassword(email: email, password: password)
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

//struct SignInVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInVIew()
//    }
//}
