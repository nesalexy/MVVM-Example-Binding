//
//  GithubRepository.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import Combine

protocol RepositoryDataSourceProtocol: BaseDataSource {
    func fetchRepositoriesWithCombine() -> AnyPublisher<[RepositoryItem], Error>
    func fetchRepositoriesWithSwiftConcurrency() async throws -> [RepositoryItem]
    func fetchRepositoriesWithClosure(completionHandler: @escaping (Result<[RepositoryItem], Error>) -> Void )
}

final class RepositoryDataSource: RepositoryDataSourceProtocol {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    /// example with combine
    func fetchRepositoriesWithCombine() -> AnyPublisher<[RepositoryItem], Error> {
        do {
            let request = try RepositoryProvider.fetchRepositories.makeRequest()
            let publisher = client.publisher(request: request)
            return defaultHandler(publisher: publisher)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    /// example with swift concurrency
    func fetchRepositoriesWithSwiftConcurrency() async throws -> [RepositoryItem] {
        let request = try RepositoryProvider.fetchRepositories.makeRequest()
        let data = try await client.data(request: request)
        let items: [RepositoryItem] = try defaultHandler(data: data)
        return items
    }
    
    /// example with closure
    func fetchRepositoriesWithClosure(completionHandler: @escaping (Result<[RepositoryItem], Error>) -> Void ) {
        do {
            let request = try RepositoryProvider.fetchRepositories.makeRequest()
            client.make(request: request) { [weak self] result in
                guard let self = self else {
                    completionHandler(.failure(DataSourceError.selfError))
                    return
                }
                
                switch result {
                case .success(let data):
                    do {
                        let items: [RepositoryItem] = try self.defaultHandler(data: data)
                        completionHandler(.success(items))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        } catch {
            completionHandler(.failure(error))
        }
    }
}

