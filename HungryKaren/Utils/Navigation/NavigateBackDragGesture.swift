//
//  NavigateBackDragGesture.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 24/01/2023.
//

import SwiftUI

struct NavigateBackDragGesture: Gesture {
    
    @GestureState private var dragOffset = CGSize.zero
    let completion: () -> Void
    
    var body: some Gesture {
        DragGesture().updating($dragOffset, body: { (value, state, transaction) in
            if value.startLocation.x < 20 && value.translation.width > 100 {
                completion()
            }
        })
    }
}
