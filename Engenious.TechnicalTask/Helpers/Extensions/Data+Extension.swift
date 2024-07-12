//
//  Data+Extension.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation

extension Data {
    
    func convertToString() -> String {
        if let jsonData = try? JSONSerialization.jsonObject(with: self, options: .allowFragments),
           let serializationData = try? JSONSerialization.data(withJSONObject: jsonData, options: [JSONSerialization.WritingOptions.prettyPrinted]),
           let string = String(data: serializationData, encoding: String.Encoding.utf8) {
            return string
        } else {
            return ""
        }
    }
}
