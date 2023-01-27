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
        ZStack {
            HKMainBackgroundCanvasView(color: tertiaryColor)
            VStack {
                HStack() {
                    Spacer()
                    Text("Home")
                        .foregroundColor(thirdTitleColor)
                        .fontWeight(.medium)
                        .font(.system(size: 24))
                        .padding(.trailing, 104)
                    Button {
                        print("Show menu")
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 27, height: 27)
                            .fontWeight(.medium)
                    }
                }
                .foregroundColor(thirdTitleColor)
                .padding(.horizontal, 20)
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
