//
//  HTTPClientClosureTests.swift
//  Engenious.TechnicalTaskTests
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

@testable import Engenious_TechnicalTask
import Foundation
import XCTest
import Combine


final class HTTPClientClosureTests: BaseHTTPClientTests {
    
    func testClosure_DataNotNil_ResponseNotNil() {
        /// Arrange
        let urlSession = makeSessionWithResponse()
        let expectation = XCTestExpectation(description: "Request by Closure with expected Data")
        
        /// Act
        urlSession.make(request: URLRequest(url: url)) { result in
            switch result {
            case .success(let output):
                XCTAssertNotNil(output.data)
                XCTAssertNotNil(output.response)
            case .failure:
                break
            }
            expectation.fulfill()
        }
        /// Assert
        wait(for: [expectation], timeout: 1)
    }
    
    func testClosure_DataNotNil_ResponseNil() {
        /// Arrange
        let urlSession = makeSession(with: (nil, Data()))
        let expectation = XCTestExpectation(description: "Request by Closure with expected Response error")
        
        /// Act
        urlSession.make(request: URLRequest(url: url)) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        /// Assert
        wait(for: [expectation], timeout: 1)
    }
    
    func testClosure_CheckStatusCode() {
        /// Arrange
        let urlSession = makeSessionWithResponse()
        let expectation = XCTestExpectation(description: "Request by Closure check status code")
        
        /// Act
        urlSession.make(request: URLRequest(url: url)) { result in
            switch result {
            case .success(let output):
                XCTAssertEqual(200, output.response.statusCode)
            case .failure:
                break
            }
            expectation.fulfill()
        }
        
        /// Assert
        wait(for: [expectation], timeout: 1)
    }
    
}
