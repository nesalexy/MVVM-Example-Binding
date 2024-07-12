//
//  StubHTTPProvider.swift
//  Engenious.TechnicalTaskTests
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

@testable import Engenious_TechnicalTask
import Foundation


enum StubHTTPPField: String {
    case repositoryID = "itemID"
}

enum StubHTTPPPath: String {
    case items = "items"
}

enum StubHTTPProvider: HTTPProvider {
    case getItems
    case getItem(id: String)
    case createItem(item: MockHTTPProvider)
    case deleteItem(id: String)
    case fullUpdateItem(id: String, item: MockHTTPProvider)
    case partialUpgradeItem(id: String, item: MockHTTPProvider)
}

extension StubHTTPProvider  {
    var scheme: String {
        Config.APIDetails.APIScheme
    }
    
    var host: String {
        Config.APIDetails.APIHost
    }
    
    var path: String? {
        switch self {
        case .getItem, .getItems, .createItem, .deleteItem, .fullUpdateItem, .partialUpgradeItem:
            StubHTTPPPath.items.rawValue
        }
    }
    
    var query: [URLQueryItem]? {
        var queryItems: [URLQueryItem]?
        
        switch self {
        case .getItem(let id):
            queryItems = [.init(name: StubHTTPPField.repositoryID.rawValue, value: id)]
        case .deleteItem(let id):
            queryItems = [.init(name: StubHTTPPField.repositoryID.rawValue, value: id)]
        case .fullUpdateItem(let id, _):
            queryItems = [.init(name: StubHTTPPField.repositoryID.rawValue, value: id)]
        case .partialUpgradeItem(let id, _):
            queryItems = [.init(name: StubHTTPPField.repositoryID.rawValue, value: id)]
        case .getItems, .createItem:
            queryItems = nil
        }
        
        return queryItems
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var method: String {
        switch self {
        case .getItems, .getItem:
            HTTPMethod.GET.rawValue
        case .createItem:
            HTTPMethod.POST.rawValue
        case .deleteItem:
            HTTPMethod.DELETE.rawValue
        case .fullUpdateItem:
            HTTPMethod.PUT.rawValue
        case .partialUpgradeItem:
            HTTPMethod.PATCH.rawValue
        }
    }
    
    var contentType: ContentType {
        ContentType.json
    }
    
    func getData() throws -> Data? {
        var data: Data?
        
        switch self {
        case .getItems, .getItem, .deleteItem:
            data = nil
        case .createItem(let item):
            data = try item.encoded()
        case .fullUpdateItem(_ , let item):
            data = try item.encoded()
        case .partialUpgradeItem(_, let item):
            data = try item.encoded()
        }
        
        return data
    }
}
