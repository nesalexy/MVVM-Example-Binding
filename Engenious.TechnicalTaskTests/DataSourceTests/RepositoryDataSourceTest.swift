//
//  RepositoryDataSourceTest.swift
//  Engenious.TechnicalTaskTests
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

import XCTest
@testable import Engenious_TechnicalTask
import Combine

// MARK: - Mock data for test
let successMockRepositoriesJson: [[String: Any]] = [
    [
        "id": 12345,
        "name": "Sample Repository 1",
        "description": "This is a sample repository for demonstration purposes.",
        "owner": [
            "login": "sampleUser1"
        ]
    ],
    [
        "id": 67890,
        "name": "Sample Repository 2",
        "description": "This is another sample repository for demonstration purposes.",
        "owner": [
            "login": "sampleUser2"
        ]
    ]
]

let errorMockRepositoriesJson: [[String: Any]] = [
    [
        "id": "12345",
        "name": "Sample Repository 1",
        "description": "This is a sample repository for demonstration purposes.",
        "owner": [
            "login": "sampleUser1"
        ]
    ],
    [
        "id": 67890,
        "name": "Sample Repository 2",
        "description": "This is another sample repository for demonstration purposes.",
        "owner": [
            "login": "sampleUser2"
        ]
    ]
]

// MARK: - Test cases
final class RepositoryDataSourceTest: XCTestCase {
    
    var client: HTTPClientMock!
    var dataSource: RepositoryDataSourceProtocol!
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        client = HTTPClientMock()
        dataSource = RepositoryDataSource(client: client)
    }
    
    // MARK: - Test Combine Cases
    func test_combine_getRepositories_responseSuccess() throws {
        let publisherRequestReturnValue = makePublisher(withStatusCode: 200,
                                                        withResponseData: successMockRepositoriesJson)
        client.publisherRequestReturnValue = publisherRequestReturnValue
        
        let expectation = XCTestExpectation(description: "Combine. Get repositories. Success")
        
        dataSource.fetchRepositoriesWithCombine()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Expected success but got error: \(error)")
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { items in
                XCTAssertTrue(!items.isEmpty)
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_combine_getRepositories_responseError() throws {
        let publisherRequestReturnValue = makePublisher(withStatusCode: 200,
                                                        withResponseData: errorMockRepositoriesJson)
        
        client.publisherRequestReturnValue = publisherRequestReturnValue
        
        let expectation = XCTestExpectation(description: "Combine. Get repositories. Error")
        
        dataSource.fetchRepositoriesWithCombine()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertNotNil(error)
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { _ in
                XCTFail("Expected error but got success")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_combine_withErrorStatusCode() throws {
        let publisherRequestReturnValue = makePublisher(withStatusCode: 500,
                                                        withResponseData: errorMockRepositoriesJson)
        client.publisherRequestReturnValue = publisherRequestReturnValue
        
        let expectation = XCTestExpectation(description: "Combine. Get repositories. Status error")
        
        dataSource.fetchRepositoriesWithCombine()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertNotNil(error)
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { _ in
                XCTFail("Expected error but got success")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Test Swift Concurrency Cases
    func test_swiftConcurrency_getRepositories_responseSuccess() throws {
        let data = makeData(withStatusCode: 200, withResponseData: successMockRepositoriesJson)
        client.swiftConcurrencyRequestReturnValue = data
        
        let expectation = expectation(description: "Swift Concurrency. Get repositories. Success")
        
        Task {
            do {
                let items = try await dataSource.fetchRepositoriesWithSwiftConcurrency()
                XCTAssertTrue(!items.isEmpty)
            } catch {
                XCTFail("Expected success but got error")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_swiftConcurrency_getRepositories_responseError() throws {
        let data = makeData(withStatusCode: 200, withResponseData: errorMockRepositoriesJson)
        client.swiftConcurrencyRequestReturnValue = data
        
        let expectation = expectation(description: "Swift Concurrency. Get repositories. Error")
        
        Task {
            do {
                let _ = try await dataSource.fetchRepositoriesWithSwiftConcurrency()
                XCTFail("Expected error but got success")
            } catch {
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_swiftConcurrency_getRepositories_withErrorStatusCode() throws {
        let data = makeData(withStatusCode: 500, withResponseData: successMockRepositoriesJson)
        client.swiftConcurrencyRequestReturnValue = data
        
        let expectation = expectation(description: "Swift Concurrency. Get repositories. Error")
        
        Task {
            do {
                let _ = try await dataSource.fetchRepositoriesWithSwiftConcurrency()
                XCTFail("Expected error but got success")
            } catch {
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Test Closure Cases
    func test_closure_getRepositories_responseSuccess() throws {
        let closure = makeCallback(withStatusCode: 200, withResponseData: successMockRepositoriesJson)
        client.closureRequestReturnValue = closure
        
        let expectation = expectation(description: "Closure. Get repositories. Success")
        
        dataSource.fetchRepositoriesWithClosure { result in
            switch result {
            case .success(let items):
                XCTAssertTrue(!items.isEmpty)
            case .failure:
                XCTFail("Expected success but got error")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_closure_getRepositories_responseError() throws {
        let closure = makeCallback(withStatusCode: 200, withResponseData: errorMockRepositoriesJson)
        client.closureRequestReturnValue = closure
        
        let expectation = expectation(description: "Closure. Get repositories. Success")
        
        dataSource.fetchRepositoriesWithClosure { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_closure_getRepositories_withErrorStatusCode() throws {
        let closure = makeCallback(withStatusCode: 500, withResponseData: successMockRepositoriesJson)
        client.closureRequestReturnValue = closure
        
        let expectation = expectation(description: "Closure. Get repositories. Success")
        
        dataSource.fetchRepositoriesWithClosure { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// MARK: - Helpers
extension RepositoryDataSourceTest {
    
    func makePublisher(withStatusCode: Int,
                       withResponseData: [[String: Any]]) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
        let httpResponse = HTTPURLResponse(url: URL(string: "http://test.com")!,
                                           statusCode: withStatusCode,
                                           httpVersion: nil, headerFields: nil)!
        let jsonResponseObject = try! JSONSerialization.data(withJSONObject: withResponseData)
        let data = (data: jsonResponseObject, response: httpResponse)
        
        return Just(data)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func makeData(withStatusCode: Int,
                  withResponseData: [[String: Any]]) -> (data: Data, response: HTTPURLResponse) {
        let httpResponse = HTTPURLResponse(url: URL(string: "http://test.com")!,
                                           statusCode: withStatusCode,
                                           httpVersion: nil, headerFields: nil)!
        let jsonResponseObject = try! JSONSerialization.data(withJSONObject: withResponseData)
        let data = (data: jsonResponseObject, response: httpResponse)
        return data
    }
    
    func makeCallback(withStatusCode: Int,
                      withResponseData: [[String: Any]]) -> Result<(data: Data, response: HTTPURLResponse), Error>? {
        do {
            let httpResponse = HTTPURLResponse(url: URL(string: "http://test.com")!,
                                               statusCode: withStatusCode,
                                               httpVersion: nil, headerFields: nil)!
            let jsonResponseObject = try JSONSerialization.data(withJSONObject: withResponseData)
            let data = (data: jsonResponseObject, response: httpResponse)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
