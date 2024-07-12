//
//  RepositoryProvider.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation

// url path(s) for current provider
enum RepositoryPath: String {
    case repositories = "users/Apple/repos"
}

// type of requests for current provider
enum RepositoryProvider {
    case fetchRepositories
}

// implementation of HTTPProvider
extension RepositoryProvider: HTTPProvider {
    var scheme: String {
        Config.APIDetails.APIScheme
    }
    
    var host: String {
        Config.APIDetails.APIHost
    }
    
    var path: String? {
        switch self {
        case .fetchRepositories:
            RepositoryPath.repositories.rawValue
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .fetchRepositories:
            nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchRepositories:
            nil
        }
    }
    
    var method: String {
        switch self {
        case .fetchRepositories:
            HTTPMethod.GET.rawValue
        }
    }
    
    var contentType: ContentType {
        switch self {
        case .fetchRepositories:
            ContentType.json
        }
    }
    
    func getData() throws -> Data? {
        switch self {
        case .fetchRepositories:
            nil
        }
    }
}
