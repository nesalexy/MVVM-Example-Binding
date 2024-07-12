//
//  Encodable+Extension.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

import Foundation

extension Encodable {
    func encoded(using encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}
