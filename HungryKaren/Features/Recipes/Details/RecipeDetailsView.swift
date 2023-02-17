//
//  RecipeDetailsView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 16/02/2023.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    var recipe: RecipeDetails
    
    var body: some View {
        Text(recipe.title)
        Text(recipe.sourceName)
        Text(recipe.summary)
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(recipe: sampleRecipeDetail)
    }
}
