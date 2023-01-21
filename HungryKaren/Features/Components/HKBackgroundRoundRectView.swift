//
//  HKBackgroundRoundRectView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 21/01/2023.
//

import SwiftUI

struct HKBackgroundRoundRectView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(primaryColor)
                .frame(width: 316, height: 510)
            Image("carrots_img")
                .resizable()
                .scaledToFill()
                .frame(width: 97, height: 114)
                .position(x: 343, y: 121)
            Image("lettuce_img")
                .resizable()
                .scaledToFill()
                .frame(width: 173, height: 148)
                .position(x: 64, y: 597)
            Image("parsley_img")
                .resizable()
                .scaledToFill()
                .frame(width: 151, height: 137)
                .position(x: 97, y: 630)
        }
    }
}

struct HKBackgroundRoundRectView_Previews: PreviewProvider {
    static var previews: some View {
        HKBackgroundRoundRectView()
    }
}
