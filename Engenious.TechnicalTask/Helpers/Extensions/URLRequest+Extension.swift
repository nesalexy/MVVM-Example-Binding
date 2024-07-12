//
//  URLRequest+Extension.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation

extension URLRequest {
    func getHeaderValue(forKey key: String) -> String? {
        return allHTTPHeaderFields?[key]
    }
}
