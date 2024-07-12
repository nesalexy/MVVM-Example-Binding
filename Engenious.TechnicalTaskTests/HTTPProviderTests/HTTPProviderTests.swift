//
//  HTTPProviderTests.swift
//  Engenious.TechnicalTaskTests
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

import XCTest
@testable import Engenious_TechnicalTask


//MARK: - Testing Provider with all cases
final class HTTPProviderTests: XCTestCase {
    
    // MARK: - GET. Check list of items
    func testItemsProvider_preparedData_GET() throws {
        let provider = StubHTTPProvider.getItems
        expectAPILink(with: provider)
        expectPath(with: provider, path: StubHTTPPPath.items.rawValue)
        expectHTTPMethod(provider: provider, httpMethod: .GET)
    }
    
    func testItemsProvider_makeRequest_GET() throws {
        let provider = StubHTTPProvider.getItems
        let request = try provider.makeRequest()
        let expectedAbsoluteString = "\(Config.APIDetails.APIScheme)://\(Config.APIDetails.APIHost)/\(StubHTTPPPath.items.rawValue)"
        
        expectAPILink(with: provider)
        XCTAssertEqual(expectedAbsoluteString, request.url?.absoluteString)
        expectHTTPMethod(request: request, httpMethod: .GET)
    }
    
    // MARK: - GET. Check separate item
    func testItemProvider_preparedData_GET() throws {
        let id = "1"
        let provider = StubHTTPProvider.getItem(id: id)
        
        expectAPILink(with: provider)
        expectPath(with: provider, path: StubHTTPPPath.items.rawValue)
        expectQuery(provider: provider, expectedQueryItems: [
            URLQueryItem(name: StubHTTPPField.repositoryID.rawValue, value: id)
        ])
        expectHTTPMethod(provider: provider, httpMethod: .GET)
    }
    
    func testItemProvider_makeRequest_GET() throws {
        let id = "1"
        let provider = StubHTTPProvider.getItem(id: id)
        let request = try provider.makeRequest()
        let expectedAbsoluteString = "\(Config.APIDetails.APIScheme)://\(Config.APIDetails.APIHost)/\(StubHTTPPPath.items.rawValue)?\(StubHTTPPField.repositoryID.rawValue)=\(id)"
        
        expectAPILink(with: provider)
        XCTAssertEqual(expectedAbsoluteString, request.url?.absoluteString)
        expectHTTPMethod(request: request, httpMethod: .GET)
    }
    
    // MARK: - Create
    func testItemProvider_preparedData_CREATE() throws {
        let id = "1"
        let mockItem = MockHTTPProvider(id: id)
        let provider = StubHTTPProvider.createItem(item: mockItem)
        
        expectAPILink(with: provider)
        expectPath(with: provider, path: StubHTTPPPath.items.rawValue)
        expectHTTPMethod(provider: provider, httpMethod: .POST)
        expectContentTypeJson(provider: provider)
        XCTAssertNotNil(try provider.getData())
    }
    
    func testItemProvider_makeRequest_CREATE() throws {
        let id = "1"
        let mockItem = MockHTTPProvider(id: id)
        let provider = StubHTTPProvider.createItem(item: mockItem)
        let request = try provider.makeRequest()
        
        let expectedAbsoluteString = "\(Config.APIDetails.APIScheme)://\(Config.APIDetails.APIHost)/\(StubHTTPPPath.items.rawValue)"
        expectAPILink(with: provider)
        XCTAssertEqual(expectedAbsoluteString, request.url?.absoluteString)
        expectHTTPMethod(request: request, httpMethod: .POST)
        XCTAssertNotNil(request.httpBody)
    }
    
    // MARK: - Delete
    func testItemProvider_preparedData_DELETE() throws {
        let id = "1"
        let provider = StubHTTPProvider.deleteItem(id: id)
        
        expectAPILink(with: provider)
        expectPath(with: provider, path: StubHTTPPPath.items.rawValue)
        expectHTTPMethod(provider: provider, httpMethod: .DELETE)
        expectQuery(provider: provider, expectedQueryItems: [
            URLQueryItem(name: StubHTTPPField.repositoryID.rawValue, value: id)
        ])
    }
    
    func testItemProvider_makeRequest_DELETE() throws {
        let id = "1"
        let provider = StubHTTPProvider.deleteItem(id: id)
        let request = try provider.makeRequest()
        
        let expectedAbsoluteString = "\(Config.APIDetails.APIScheme)://\(Config.APIDetails.APIHost)/\(StubHTTPPPath.items.rawValue)?\(StubHTTPPField.repositoryID.rawValue)=\(id)"
        
        expectAPILink(with: provider)
        XCTAssertEqual(expectedAbsoluteString, request.url?.absoluteString)
        expectHTTPMethod(request: request, httpMethod: .DELETE)
    }
    
    // MARK: - PUT
    func testItemProvider_preparedData_PUT() throws {
        let id = "1"
        let provider = StubHTTPProvider.fullUpdateItem(id: id, item: .init(id: "1", name: "test"))
        
        expectAPILink(with: provider)
        expectPath(with: provider, path: StubHTTPPPath.items.rawValue)
        expectQuery(provider: provider, expectedQueryItems: [
            URLQueryItem(name: StubHTTPPField.repositoryID.rawValue, value: id)
        ])
        expectHTTPMethod(provider: provider, httpMethod: .PUT)
        XCTAssertNotNil(try provider.getData())
    }
    
    func testItemProvider_makeRequest_PUT() throws {
        let id = "1"
        let provider = StubHTTPProvider.fullUpdateItem(id: id, item: .init(id: "1", name: "test"))
        let request = try provider.makeRequest()
        
        let expectedAbsoluteString = "\(Config.APIDetails.APIScheme)://\(Config.APIDetails.APIHost)/\(StubHTTPPPath.items.rawValue)?\(StubHTTPPField.repositoryID.rawValue)=\(id)"
        
        expectAPILink(with: provider)
        XCTAssertEqual(expectedAbsoluteString, request.url?.absoluteString)
        expectHTTPMethod(request: request, httpMethod: .PUT)
        XCTAssertNotNil(request.httpBody)
    }
    
    // MARK: - PATCH
    func testItemProvider_preparedData_PATCH() throws {
        let id = "1"
        let provider = StubHTTPProvider.partialUpgradeItem(id: id, item: .init(id: "1", name: "test"))
        
        expectAPILink(with: provider)
        expectPath(with: provider, path: StubHTTPPPath.items.rawValue)
        expectQuery(provider: provider, expectedQueryItems: [
            URLQueryItem(name: StubHTTPPField.repositoryID.rawValue, value: id)
        ])
        expectHTTPMethod(provider: provider, httpMethod: .PATCH)
        XCTAssertNotNil(try provider.getData())
    }
    
    func testItemProvider_makeRequest_PATCH() throws {
        let id = "1"
        let provider = StubHTTPProvider.partialUpgradeItem(id: id, item: .init(id: "1", name: "test"))
        let request = try provider.makeRequest()
        
        let expectedAbsoluteString = "\(Config.APIDetails.APIScheme)://\(Config.APIDetails.APIHost)/\(StubHTTPPPath.items.rawValue)?\(StubHTTPPField.repositoryID.rawValue)=\(id)"
        
        expectAPILink(with: provider)
        XCTAssertEqual(expectedAbsoluteString, request.url?.absoluteString)
        expectHTTPMethod(request: request, httpMethod: .PATCH)
        XCTAssertNotNil(request.httpBody)
    }
}

// MARK: - Helpers
extension HTTPProviderTests {
    func expectAPILink(with provider: StubHTTPProvider,
                       file: StaticString = #file,
                       line: UInt = #line) {
        XCTAssertEqual(Config.APIDetails.APIScheme, provider.scheme)
        XCTAssertEqual(Config.APIDetails.APIHost, provider.host)
    }
    
    func expectPath(with provider: StubHTTPProvider,
                    path: String,
                    file: StaticString = #file,
                    line: UInt = #line) {
        XCTAssertEqual(path, provider.path)
    }
    
    func expectQueryNil(provider: StubHTTPProvider,
                        file: StaticString = #file,
                        line: UInt = #line) {
        XCTAssertNil(provider.query)
    }
    
    func expectHeaderNil(provider: StubHTTPProvider,
                         file: StaticString = #file,
                         line: UInt = #line) {
        XCTAssertNil(provider.headers)
    }
    
    func expectHTTPMethod(provider: StubHTTPProvider,
                          httpMethod: HTTPMethod,
                          file: StaticString = #file,
                          line: UInt = #line) {
        XCTAssertEqual(httpMethod.rawValue, provider.method)
    }
    
    func expectHTTPMethod(request: URLRequest,
                          httpMethod: HTTPMethod,
                          file: StaticString = #file,
                          line: UInt = #line) {
        XCTAssertEqual(request.httpMethod, httpMethod.rawValue)
    }
    
    func expectDataNil(provider: StubHTTPProvider,
                       file: StaticString = #file,
                       line: UInt = #line) {
        XCTAssertNil(try provider.getData())
    }
    
    func expectContentTypeJson(provider: StubHTTPProvider,
                               file: StaticString = #file,
                               line: UInt = #line) {
        XCTAssertEqual(ContentType.json, provider.contentType)
    }
        
    func expectQuery(provider: StubHTTPProvider,
                     expectedQueryItems: [URLQueryItem],
                     file: StaticString = #file,
                     line: UInt = #line) {
        for (index, queryItem) in expectedQueryItems.enumerated() {
            XCTAssertEqual(provider.query?[index].name, queryItem.name)
            XCTAssertEqual(provider.query?[index].value, queryItem.value)
        }
    }
}
