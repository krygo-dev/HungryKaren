//
//  SignUpView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter

    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    private let fieldHeight: CGFloat = 41
    private let fontSize: CGFloat = 19
    
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
                        text: $name,
                        placeholder: "name",
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
                    Text(authViewModel.alert?.message() ?? "")
                        .truncationMode(.tail)
                        .foregroundColor(errorTextColor)
                        .fontWeight(.medium)
                        .font(.system(size: 10))
                        .frame(width: 200, height: 28, alignment: .center)

                }
                Spacer().frame(height: 35)
                Button {
                    authViewModel.signUpWithEmailAndPassword(
                        email: email,
                        name: name,
                        password: password,
                        confirmPassword: confirmPassword) {
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
                Spacer().frame(height: 116)
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

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
