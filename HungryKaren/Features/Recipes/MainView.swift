//
//  MainView.swift
//  HungryKaren
//
//  Created by Ewelina Klekot on 27/01/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var selectedScreen: Screen = .home
    
    var body: some View {
        VStack {
            Text("Main")
            Spacer()
            HKBottomBarView(selectedScreen: $selectedScreen)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
