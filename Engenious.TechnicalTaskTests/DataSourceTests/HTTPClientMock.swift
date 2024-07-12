//
//  HTTPClientMock.swift
//  Engenious.TechnicalTaskTests
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

import XCTest
@testable import Engenious_TechnicalTask
import Combine


class HTTPClientMock: HTTPClient {
    
    var publisherRequestReturnValue: AnyPublisher<(data: Data, response: HTTPURLResponse), Error>?
    var swiftConcurrencyRequestReturnValue: (data: Data, response: HTTPURLResponse)?
    var closureRequestReturnValue: Result<(data: Data, response: HTTPURLResponse), Error>?
    
    func publisher(request: URLRequest) -> AnyPublisher<(data: Data, response: HTTPURLResponse), any Error> {
        return publisherRequestReturnValue!
    }
    
    func data(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        return swiftConcurrencyRequestReturnValue!
    }
    
    func make(request: URLRequest, _ completion: @escaping (Result<(data: Data, response: HTTPURLResponse), any Error>) -> Void) {
        completion(closureRequestReturnValue!)
    }
}
