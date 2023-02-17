//
//  RecipeDetailsView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 16/02/2023.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    var recipe: RecipeDetails
    
    var body: some View {
        VStack {
            Text(recipe.title)
            Text(recipe.sourceName)
            Text(recipe.summary)
        }
        .navigationBarBackButtonHidden(true)
        .gesture(NavigateBackDragGesture(completion: { navigationRouter.navigateBack() }))
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(recipe: sampleRecipeDetail)
    }
}
