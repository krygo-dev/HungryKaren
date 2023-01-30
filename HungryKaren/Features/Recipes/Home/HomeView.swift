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
    
    var show: Binding<Bool>?
    
    var body: some View {
        ZStack {
//            HKMainBackgroundCanvasView(color: tertiaryColor)
            ScrollView {
                HStack {
                    Text("Recipes ideas")
                        .font(.system(size: 22))
                        .fontWeight(.medium)
                        .foregroundColor(secondTitleColor)
                    Spacer()
                }
                .padding(.horizontal, 20)
                ForEach(0..<5) { i in
                    HKRecipeListItemView()
                }
            }
            .scrollIndicators(.never)
        }
        .navigationBarBackButtonHidden(true)
//        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


