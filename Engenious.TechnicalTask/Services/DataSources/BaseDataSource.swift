//
//  BaseDataSource.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//
import Foundation
import Combine


protocol BaseDataSource {
    init(client: HTTPClient)
    func defaultHandler<T>(publisher: AnyPublisher<(data: Data, response: HTTPURLResponse), Error>) -> AnyPublisher<T, Error> where T: Decodable
}

extension BaseDataSource {
    
    func defaultHandler<T>(publisher: AnyPublisher<(data: Data, response: HTTPURLResponse), Error>) -> AnyPublisher<T, Error> where T: Decodable {
        publisher
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .tryMap(DefaultMapping.map)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func defaultHandler<T>(data: (data: Data, response: HTTPURLResponse)) throws -> T where T: Decodable {
        try DefaultMapping.map(data: data.data, response: data.response)
    }
}

// MARK: - Default mapping for dataSource
final class DefaultMapping {
    
    static func map<T>(data: Data, response: HTTPURLResponse) throws -> T where T: Decodable {
        /// can handle specific http codes
        if (500...600).contains(response.statusCode) {
            throw DataSourceError.mapError
        }
        
        return try T.self.decoded(from: data)
    }
}

