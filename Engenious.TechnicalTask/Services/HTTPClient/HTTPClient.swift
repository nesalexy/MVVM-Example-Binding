//
//  HTTPClient.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import Combine

enum HTTPClientError: Error {
    case httpCastingError
    case dataError
}

// Ability to use different approaches for URLSession. We can use Combine, Async/Await or Callback
protocol HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error>
    func data(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse)
    func make(request: URLRequest, _ completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> ())
}

// MARK: - Implementation
extension URLSession: HTTPClient  {
    
    // HTTPClient implementation based on Combine
    func publisher(request: URLRequest) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
        return dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw HTTPClientError.httpCastingError
                }
                
                return (data: result.data, response: httpResponse)
            }
            .eraseToAnyPublisher()
    }
    
    // HTTPClient implementation based on Async/Await
    func data(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        let result = try await data(for: request)
        let response = result.1
        let data = result.0
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPClientError.httpCastingError
        }
        return (data: data, response: httpResponse)
    }
    
    // HTTPClient implementation based on Callback
    func make(request: URLRequest, _ completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> ()) {
        dataTask(with: request) { data, response, error in
            var result: (Result<(data: Data, response: HTTPURLResponse), Error>)
            
            defer {
                completion(result)
            }
            
            if let error = error {
                result = .failure(error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                result = .failure(HTTPClientError.httpCastingError)
                return
            }
            
            guard let unwrappedData = data else {
                result = .failure(HTTPClientError.dataError)
                return
            }
            
            result = .success((data: unwrappedData, response: httpResponse))
        }
        .resume()
    }
}


