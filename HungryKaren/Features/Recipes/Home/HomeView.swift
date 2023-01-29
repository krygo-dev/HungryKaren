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
    
    @State var showMenu: Bool = false
    
    var body: some View {
        ZStack {
            HKMainBackgroundCanvasView(color: tertiaryColor)
            VStack {
                HKTopBarView(title: "Home", showMenu: $showMenu)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
