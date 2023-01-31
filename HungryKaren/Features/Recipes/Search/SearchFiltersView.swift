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
            .frame(width: 390, height: 756)
            .background(.white)
            .cornerRadius(25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(showFilters ? .black.opacity(0.35) : .clear)
        .onTapGesture {
            withAnimation(.easeOut.speed(1.5)) {
                showFilters.toggle()
            }
        }
        .ignoresSafeArea()
        .offset(y: showFilters ? 0 : 800)
    }
}

struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFiltersView(showFilters: .constant(true))
    }
}
