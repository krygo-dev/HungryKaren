//
//  FavouritesView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 02/02/2023.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject var favouritesViewModel: FavouritesViewModel
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        Text("Favourites")
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
