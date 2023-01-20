//
//  StartupView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 20/01/2023.
//

import SwiftUI

struct StartupView: View {
    var body: some View {
        ZStack {
            BackgroundCanvasView(
                color: secondaryColor,
                strokeWidth: 5,
                smallCircleRadius: 119,
                bigCircleRadius: 228,
                arcRadius: 135)
        }
    }
}

struct StartupView_Previews: PreviewProvider {
    static var previews: some View {
        StartupView()
    }
}
