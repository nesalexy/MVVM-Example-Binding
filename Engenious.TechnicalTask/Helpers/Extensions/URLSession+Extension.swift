//
//  URLSession+Extension.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation

extension URLSession {
    
    func logResponseJSON(data: Data) {
        print("Response <= \(data.convertToString())")
    }
    
    func logRequestJSON(request: URLRequest) {
        print("Request httpHeader => \(request.allHTTPHeaderFields ?? [:])")
        print("Request url => \(request.url?.absoluteString ?? "")")
        print("Request httpMethod => \(request.httpMethod ?? "")")
        print("Request httpBody => \(request.httpBody?.convertToString() ?? "")")
    }
}
