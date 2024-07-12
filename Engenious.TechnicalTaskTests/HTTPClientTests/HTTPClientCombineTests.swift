//
//  HTTPClientCombineTests.swift
//  Engenious.TechnicalTaskTests
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

@testable import Engenious_TechnicalTask
import Foundation
import XCTest
import Combine

final class HTTPClientCombineTests: BaseHTTPClientTests {
        
    func testPublisher_DataNotNil_ResponseNotNil() {
        /// Arrange
        let urlSession = makeSessionWithResponse()
        let expectation = XCTestExpectation(description: "Request by Combine with expected Data")
        
        /// Act
        urlSession.publisher(request: URLRequest(url: url))
            .sink { data in
                if case .failure(let error) = data {
                    /// Assert
                    XCTAssertNil(error)
                }
                expectation.fulfill()
            } receiveValue: { result in
                XCTAssertNotNil(result.data)
                XCTAssertNotNil(result.response)
            }
            .store(in: &cancellables)
        
        
        /// Assert
        wait(for: [expectation], timeout: 1)
    }
    
    func testPublisher_DataNotNil_ResponseNil() {
        /// Arrange
        let urlSession = makeSession(with: (nil, Data()))
        let expectation = XCTestExpectation(description: "Request by Combine with expected Response nil(error)")
        
        /// Act
        urlSession.publisher(request: URLRequest(url: url))
            .sink { data in
                if case .failure(let error) = data {
                    /// Assert
                    XCTAssertNotNil(error)
                }
                expectation.fulfill()
            } receiveValue: {_ in }
            .store(in: &cancellables)
        
        /// Assert
        wait(for: [expectation], timeout: 1)
    }
    
    func testPublisher_CheckStatusCode() {
        /// Arrange
        let urlSession = makeSessionWithResponse()
        let expectation = XCTestExpectation(description: "Request by Combine check status code")
        
        /// Act
        urlSession.publisher(request: URLRequest(url: url))
            .sink { _ in
            } receiveValue: { result in
                XCTAssertEqual(result.response.statusCode, 200)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        /// Assert
        wait(for: [expectation], timeout: 1)
    }
}
