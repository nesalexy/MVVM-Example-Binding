//
//  RepositoryProviderTests.swift
//  Engenious.TechnicalTaskTests
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

import XCTest
@testable import Engenious_TechnicalTask

final class RepositoryProviderTests: XCTestCase {
    
    func testRepositoriesProvider_preparedData_GET() throws {
        let provider = RepositoryProvider.fetchRepositories
        
        XCTAssertEqual(Config.APIDetails.APIScheme, provider.scheme)
        XCTAssertEqual(Config.APIDetails.APIHost, provider.host)
        
        XCTAssertEqual(RepositoryPath.repositories.rawValue, provider.path)
        
        XCTAssertEqual(HTTPMethod.GET.rawValue, provider.method)
    }
    
    func testRepositoriesProvider_makeRequest_GET() throws {
        let provider = RepositoryProvider.fetchRepositories
        let request = try provider.makeRequest()
        
        let expectedAbsoluteString = "\(Config.APIDetails.APIScheme)://\(Config.APIDetails.APIHost)/\(RepositoryPath.repositories.rawValue)"
        
        XCTAssertEqual(HTTPMethod.GET.rawValue, request.httpMethod)
        XCTAssertEqual(expectedAbsoluteString, request.url?.absoluteString)
    }
}
