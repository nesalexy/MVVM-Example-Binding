//
//  RepositoryExchange.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation

struct RepositoryItem: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let owner: Owner
    
    struct Owner: Decodable {
        let login: String
    }
}
