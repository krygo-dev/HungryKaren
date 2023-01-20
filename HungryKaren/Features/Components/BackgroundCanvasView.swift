//
//  BackgroundCanvasView.swift
//  HungryKaren
//
//  Created by Ewelina Klekot on 20/01/2023.
//

import SwiftUI

struct BackgroundCanvasView: View {
    
    let color: Color
    let strokeWidth: CGFloat
    let smallCircleRadius: CGFloat
    let bigCircleRadius: CGFloat
    let arcRadius: CGFloat
    
    var body: some View {
        Canvas { context, size in
            context.fill(
                Path { path in
                    path.addArc(
                        center: CGPoint(x: 0, y: size.height),
                        radius: bigCircleRadius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360),
                        clockwise: true
                    )
                    path.closeSubpath()
                    
                    path.addArc(
                        center: CGPoint(x: size.width, y: 0),
                        radius: smallCircleRadius,
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
                        center: CGPoint(x: size.width, y: 0),
                        radius: arcRadius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360),
                        clockwise: true
                    )
                    path.closeSubpath()
                }, with: .color(color), style: .init(lineWidth: strokeWidth)
            )
        }
        .ignoresSafeArea()
    }
}

struct BackgroundCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCanvasView(
            color: secondaryColor,
            strokeWidth: 5,
            smallCircleRadius: 119,
            bigCircleRadius: 228,
            arcRadius: 135)
    }
}
