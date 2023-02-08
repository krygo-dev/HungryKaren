//
//  ForgotPasswordView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter

    @State var email: String = ""
    
    var body: some View {
        ZStack {
            HKAuthBackgroundCanvasView(
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
                Text(authViewModel.alert?.message() ?? "")
                    .truncationMode(.tail)
                    .foregroundColor(errorTextColor)
                    .fontWeight(.medium)
                    .font(.system(size: 10))
                    .frame(width: 200, height: 28, alignment: .center)
                Spacer().frame(height: 29)
                Button {
                    authViewModel.forgotPassword(email: email) {
                        if authViewModel.alert == nil {
                            navigationRouter.navigateBack()
                        }
                    }
                } label: {
                    if authViewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("send")
                            .fontWeight(.medium)
                            .font(.system(size: 16))
                            .foregroundColor(mainTextColor)
                    }
                }
                Spacer().frame(height: 177)
            }
            .frame(width: 316, height: 510)
        }
        .navigationBarBackButtonHidden(true)
        .gesture(NavigateBackDragGesture(completion: { navigationRouter.navigateBack() }))
        .onAppear {
            authViewModel.removeAlert()
        }
    }
}

//struct ForgotPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPasswordView()
//    }
//}
