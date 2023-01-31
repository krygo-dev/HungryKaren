//
//  HomeView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct HomeView: View {
    
//    @EnvironmentObject var authViewModel: AuthenticationViewModel
//    @EnvironmentObject var navigationRouter: NavigationRouter
    
    @State var offset: CGFloat = 0
    @State var previousOffset: CGFloat = 0
    @Binding var showTopBar: Bool
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 3) {
                Text("Recipes ideas")
                    .font(.system(size: 22))
                    .fontWeight(.medium)
                    .foregroundColor(secondTitleColor)
                    .padding(.leading, 17)
                ForEach(0..<10) { _ in
                    HKRecipeListItemView()
                }
            }
            .padding(.vertical, 40)
            .overlay {
                GeometryReader { proxy -> Color in
                    
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    let durationOffset: CGFloat = 35
                    
                    DispatchQueue.main.async {
                        
                        if minY < offset {
                            if offset < 0 && -minY > (previousOffset + durationOffset) {
                                withAnimation(.easeOut.speed(1.5)) {
                                    showTopBar = false
                                }
                                
                                previousOffset = -offset
                            }
                        }
                        
                        if minY > offset && -minY < (previousOffset - durationOffset) {
                            withAnimation(.easeOut.speed(1.5)) {
                                showTopBar = true
                            }

                            previousOffset = -offset
                        }
                        
                        
                        self.offset = minY
                    }
                    
                    return Color.clear
                }
            }
        }
        .coordinateSpace(name: "SCROLL")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showTopBar: .constant(true))
    }
}


