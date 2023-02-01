//
//  HKSearchBarView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 29/01/2023.
//

import SwiftUI

struct HKSearchBarView: View {
    
    @Binding var showFilters: Bool
    @Binding var searchText: String
    let backgroundColor: Color
    
    var body: some View {
        HStack {
            TextField(
                "",
                text: $searchText,
                prompt: Text("Search").foregroundColor(mainTextColor)
            )
            .multilineTextAlignment(.leading)
            .lineLimit(1)
            
            Button {
                withAnimation(.easeOut.speed(0.7)) {
                    showFilters.toggle()
                }
            } label: {
                Image(systemName: "line.horizontal.3.decrease")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 19, height: 19)
                    .foregroundColor(mainTextColor)
            }

        }
        .frame(height: 53)
        .padding(.horizontal, 17)
        .background(backgroundColor)
        .cornerRadius(15)
        .foregroundColor(secondTitleColor)
        .fontWeight(.medium)
    }
}

struct HKSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        HKSearchBarView(
            showFilters: .constant(false),
            searchText: .constant(""),
            backgroundColor: searchBarBgColor)
    }
}
