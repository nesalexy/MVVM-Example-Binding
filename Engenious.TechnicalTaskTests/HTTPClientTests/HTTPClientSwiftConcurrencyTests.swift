//
//  HTTPClientSwiftConcurrencyTests.swift
//  Engenious.TechnicalTaskTests
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

@testable import Engenious_TechnicalTask
import Foundation
import XCTest
import Combine

final class HTTPClientSwiftConcurrencyTests: BaseHTTPClientTests {
    
    func testSwiftConcurrency_DataNotNil_ResponseNotNil() async throws {
        let urlSession = makeSessionWithResponse()
        let result = try await urlSession.data(request: URLRequest(url: url))
        XCTAssertNotNil(result.data)
        XCTAssertNotNil(result.response)
    }
    
    func testSwiftConcurrency_CheckStatusCode() async throws {
        let urlSession = makeSession(with: (HTTPURLResponse(url: url,
                                                            statusCode: 200,
                                                            httpVersion: nil,
                                                            headerFields: nil)!,
                                            Data()))
        
        let result = try await urlSession.data(request: URLRequest(url: url))
        XCTAssertEqual(200, result.response.statusCode)
    }
    
}
