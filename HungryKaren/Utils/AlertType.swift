//
//  AlertType.swift
//  HungryKaren
//
//  Created by Adam Chylaszek on 25/01/2023.
//

import SwiftUI

enum AlertType {
    
    case success(message: String = "")
    case error(message: String = "")
    case info(message: String = "")
    
    var actionButtonLabel: String { return "Ok" }
    
    func title() -> String {
        switch self {
            case .success(message: _): return "Success"
            case .error(message: _): return "Error"
            case .info(message: _): return "Info"
        }
    }
    
    func message() -> String {
        switch self {
            case .success(message: let message): return message
            case .error(message: let message): return message
            case .info(message: let message): return message
        }
    }
}
