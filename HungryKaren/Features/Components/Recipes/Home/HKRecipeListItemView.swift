//
//  HKRecipeListItemView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 30/01/2023.
//

import SwiftUI

struct HKRecipeListItemView: View {
    
    let recipe: RecipeDetails
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(recipe.title)
                        .font(.system(size: 18))
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    Spacer()
                }
                .frame(minWidth: 150, maxWidth: 190)
                .padding(.top, 17)
                
                VStack(alignment: .leading) {
                    Text("Cook time: \(recipe.readyInMinutes) mins")
                    Text("Servings: \(recipe.servings)")
                    Text("Health score: \(recipe.healthScore)")
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
                AsyncImage(url: URL(string: recipe.image)) { res in
                    if let image = res.image {
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 122, height: 122)
                            .clipShape(Circle())
                    } else {
                        ProgressView()
                            .frame(width: 122, height: 122)
                    }
                }
            }
            .frame(width: 350)
            .padding(.bottom, 60)
        }
    }
}
