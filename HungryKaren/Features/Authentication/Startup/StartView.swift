//
//  StartView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    @State var animate: Bool = false
    
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .stroke(secondaryColor, lineWidth: 5)
                    .frame(width: 270)
                    .position(x: 370, y: 0)
                    .offset(
                        x: animate ? 150 : 0 ,
                        y: animate ? -150 : 0
                    )
                Circle()
                    .frame(width: 238)
                    .position(x: 370, y: 0)
                    .offset(
                        x: animate ? 120 : 0 ,
                        y: animate ? -120 : 0
                    )
                Circle()
                    .frame(width: 457)
                    .position(x: 0, y: 843)
                    .offset(
                        x: animate ? -230 : 0 ,
                        y: animate ? 230 : 0
                    )
                    
            }
            .foregroundColor(secondaryColor)
            .ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 173)
                Image("hungry_karen_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 170)
                    .scaleEffect(animate ? 1 : 1.5)
                    .offset(y: animate ? -50 : 100)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 65)
                    .fill(primaryColor)
                VStack {
                    Spacer().frame(height: 66)
                    NavigationLink(value: Route.signInView) {
                        HKButtonFrameView(text: "Sign In")
                    }
                    Spacer().frame(height: 30)
                    NavigationLink(value: Route.signUpView) {
                        HKButtonFrameView(text: "Sign Up")
                    }
                    Spacer()
                }
            }
            .position(x: 195, y: 466)
            .frame(width: 390, height: 466)
            .offset(y: animate ? 0 : 500)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                if authViewModel.currentUser != nil {
                    navigationRouter.navigate(route: .mainView)
                } else {
                    withAnimation {
                        animate.toggle()
                    }
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(AuthenticationViewModel())
            .environmentObject(NavigationRouter())
    }
}
