//
//  PreferencesView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 02/02/2023.
//

import SwiftUI

struct PreferencesView: View {
    
    @StateObject var preferencesViewModel = PreferencesViewModel()
    
    var body: some View {
        Text("Preferences")
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
