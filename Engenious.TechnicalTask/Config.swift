//
//  Config.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation

public enum Environment: String {
    case release = "Release"
    case debug = "Debug"
}


public struct Config {
    
    struct APIDetails {
        public static var APIScheme: String {
            return "https"
        }
        
        public static var APIHost: String {
            return "api.github.com"
        }
        
        public static var API: String {
            return "\(APIScheme)://\(APIHost)"
        }
    }
}
