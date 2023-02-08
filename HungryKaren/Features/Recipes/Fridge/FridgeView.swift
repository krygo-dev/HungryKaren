//
//  FridgeView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct FridgeView: View {
    
    @State var showProducts: Bool = false
    @State var showSpices: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    HKFridgeCategoryRowView(showList: $showProducts, title: "products")
                    
                    if showProducts {
                        
                        HKFridgeProductRowView(bgColor: alternatePrimaryColor)
                        
                        
                        ForEach(Array(sampleProducts.enumerated()), id: \.element) { index, product in
                            HKFridgeProductRowView(product: product, bgColor: index % 2 == 0 ? alternateSecondaryColor : alternatePrimaryColor)
                        }
                    }
                    
                    HKFridgeCategoryRowView(showList: $showSpices, title: "spices")
                    
                    if showSpices {
                        
                        HKFridgeProductRowView(bgColor: alternatePrimaryColor)
                        
                        ForEach(Array(sampleProducts.enumerated()), id: \.element) { index, product in
                            HKFridgeProductRowView(product: product, bgColor: index % 2 == 0 ? alternateSecondaryColor : alternatePrimaryColor)
                        }
                    }
                }
                .padding(.horizontal, 17)
            }
            .padding(.vertical, 20)
            .frame(width: 316, height: 548)
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.black, lineWidth: 1)
            }
            Spacer()
        }
    }
}

struct FridgeView_Previews: PreviewProvider {
    static var previews: some View {
        FridgeView()
    }
}
