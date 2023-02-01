//
//  SearchFiltersView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 31/01/2023.
//

import SwiftUI

struct SearchFiltersView: View {
    
    @Binding var showFilters: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Col 1")
                Text("Col 2")
            }
        }
        .frame(width: 390, height: 756)
        .background(.white)
        .cornerRadius(25)
        .ignoresSafeArea()
    }
}

struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFiltersView(showFilters: .constant(true))
    }
}
