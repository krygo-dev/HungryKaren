//
//  SignInVIew.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct SignInVIew: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    @State var email: String = ""
    @State var password: String = ""
    
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
                    Text(authViewModel.alert?.message() ?? "")
                        .truncationMode(.tail)
                        .foregroundColor(errorTextColor)
                        .fontWeight(.medium)
                        .font(.system(size: 10))
                        .frame(width: 200, height: 28, alignment: .center)
                    HKTextFieldView(
                        text: $password,
                        placeholder: "password",
                        fieldHeight: 58,
                        isSecureField: true
                    )
                }
                Spacer().frame(height: 6)
                NavigationLink(value: Route.forgotPasswordView) {
                    Text("forgot password")
                        .fontWeight(.medium)
                        .font(.system(size: 12))
                        .foregroundColor(mainTextColor)
                }
                Spacer().frame(height: 29)
                Button {
                    authViewModel.signInWithEmailAndPassword(email: email, password: password) {
                        if authViewModel.currentUser != nil {
                            navigationRouter.navigate(route: .mainView)
                        }
                    }
                } label: {
                    if authViewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("okay")
                            .fontWeight(.medium)
                            .font(.system(size: 16))
                            .foregroundColor(mainTextColor)
                    }
                }
                Spacer().frame(height: 111)
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

//struct SignInVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInVIew()
//    }
//}
