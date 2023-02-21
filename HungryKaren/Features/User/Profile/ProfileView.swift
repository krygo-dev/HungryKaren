//
//  ProfileView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 02/02/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject var profileViewModel = ProfileViewModel()
    @State var showMenu: Bool = false
    
    var body: some View {
        ZStack {
            HKMainBackgroundCanvasView(color: tertiaryColor)
            
            VStack {
                HKTopBarView(title: "My profile", showMenu: $showMenu, showTopBar: .constant(true))
                
                Image("person_icon_with_bg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 162, height: 162)
                
                HKSecondaryBottomBarView(
                    searchText: .constant(""),
                    showBottomBar: .constant(true),
                    searchBarVisible: false,
                    searchBarButtonVisible: false
                )
            }
            
            if showMenu {
                MenuView(showMenu: $showMenu)
                    .transition(AnyTransition.opacity.animation(.easeOut(duration: 0.5)))
            }
        }
        .navigationBarBackButtonHidden(true)
        .gesture(NavigateBackDragGesture(completion: { navigationRouter.navigateBack() }))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(NavigationRouter())
    }
}
