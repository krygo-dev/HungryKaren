//
//  HomeView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                authViewModel.signOut() { success in
                    navigationRouter.navigateBackToStart()
                }
            } label: {
                Text("Sign out")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
