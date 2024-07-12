//
//  ContentType.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation

enum ContentType {
    case json
    
    var key: String {
        "Content-Type"
    }
    
    var value: String {
        switch self {
        case .json:
            "application/json; charset=utf-8"
        }
    }
}
