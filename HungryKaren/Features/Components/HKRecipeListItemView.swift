//
//  HKRecipeListItemView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 30/01/2023.
//

import SwiftUI

struct HKRecipeListItemView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Porridge")
                        .font(.system(size: 18))
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                .padding(.top, 17)
                VStack(alignment: .leading) {
                    Text("Prep time: 5 mins")
                    Text("Cook time: 3 mins")
                    Text("Servings: 1")
                }
                .foregroundColor(mainTextColor)
                Spacer().frame(height: 25)
                HStack {
                    Rectangle()
                        .frame(width: 217, height: 1)
                        .foregroundColor(mainTextColor)
                    Text("ENTER RECIPE")
                }
                .padding(.bottom, 17)
            }
            .frame(width: 350, height: 126)
            .background(primaryColor)
            .cornerRadius(25)
            .font(.system(size: 10))
            .fontWeight(.medium)
            .foregroundColor(thirdTitleColor)
            
            HStack(alignment: .top) {
                Spacer()
                Circle()
                    .frame(width: 122, height: 122)
            }
            .frame(width: 350, height: 167)
            .padding(.bottom, 60)
        }
    }
}

//struct HKRecipeListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        HKRecipeListItemView()
//    }
//}
