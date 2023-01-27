//
//  HKMainBackgroundCanvasView.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 27/01/2023.
//

import SwiftUI

struct HKMainBackgroundCanvasView: View {
    
    let color: Color
    
    var body: some View {
        Canvas { context, size in
            context.fill(
                Path { path in
                    path.addArc(
                        center: CGPoint(x: 0, y: 0),
                        radius: 118,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360),
                        clockwise: true
                    )
                    path.closeSubpath()
                }, with: .color(color)
            )
            
            context.stroke(
                Path { path in
                    path.addArc(
                        center: CGPoint(x: 0, y: 0),
                        radius: 144,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360),
                        clockwise: true
                    )
                    path.closeSubpath()
                }, with: .color(color), style: .init(lineWidth: 3)
            )
        }
        .ignoresSafeArea()
    }
}

struct HKBackgroundCanvasRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        HKMainBackgroundCanvasView(
            color: tertiaryColor
        )
    }
}
