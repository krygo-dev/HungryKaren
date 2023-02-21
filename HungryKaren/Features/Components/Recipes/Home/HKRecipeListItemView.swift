//
//  HKRecipeListItemView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 30/01/2023.
//

import SwiftUI

struct HKRecipeListItemView: View {
    
    @Environment(\.openURL) var openUrl
    
    var recipe: RecipeDetails
    var recipeInFav: Bool
    @Binding var showDetails: [Int: Bool]
    var onItemTap: () -> Void
    var onHeartTap: () -> Void
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(recipe.title)
                        .font(.system(size: 18))
                    Image(systemName: recipeInFav ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .onTapGesture {
                            onHeartTap()
                        }
                        .animation(.easeOut(duration: 0.3), value: recipeInFav)
                    Spacer()
                }
                .frame(minWidth: 150, maxWidth: 190)
                .padding(.top, 17)
                
                VStack(alignment: .leading) {
                    Text("Cook time: \(recipe.readyInMinutes) mins")
                    Text("Servings: \(recipe.servings)")
                    Text("Health score: \(String(format: "%.2f", recipe.healthScore))")
                    
                    if showDetails[recipe.id]! {
                        Text("Author: \(recipe.sourceName)")
                            .font(.system(size: 14))
                            .foregroundColor(thirdTitleColor)
                            .padding(.vertical, 4)
                        Button {
                            openUrl(URL(string: recipe.sourceUrl)!)
                        } label: {
                            Text("Link to recipe")
                                .font(.system(size: 14))
                                .foregroundColor(thirdTitleColor)
                        }
                        Spacer()
                        Text("\(recipe.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))")
                            .font(.system(size: 14))
                        Spacer()
                    }
                }
                .foregroundColor(mainTextColor)
                
                Spacer()
                
                HStack {
                    Rectangle()
                        .frame(width: 217, height: 1)
                        .foregroundColor(mainTextColor)
                    Text(showDetails[recipe.id]! ? "CLOSE RECIPE" : "ENTER RECIPE")
                }
                .padding(.bottom, 17)
            }
            .padding(.horizontal, showDetails[recipe.id]! ? 17 : 0)
            .frame(width: 350, height: showDetails[recipe.id]! ? 536 : 126)
            .background(primaryColor)
            .cornerRadius(25)
            .font(.system(size: 10))
            .fontWeight(.medium)
            .foregroundColor(thirdTitleColor)
            
            VStack {
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
                .padding(.top, showDetails[recipe.id]! ? 8 : 0)
                .padding(.trailing, showDetails[recipe.id]! ? 17 : 0)
                
                Spacer()
            }
        }
        .onTapGesture {
            onItemTap()
        }
    }
}
