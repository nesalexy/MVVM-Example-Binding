//
//  RepositoryListViewModel.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import Combine

enum RepositoryListViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(String)
}

final class RepositoryListViewModel {
    
    @Published private(set) var userName = ""
    @Published private(set) var items = [RepositoryItem]()
    @Published private(set) var state: RepositoryListViewModelState = .loading
    
    private var cancellables = Set<AnyCancellable>()
    
    private let repositoryDataSource: RepositoryDataSourceProtocol
    
    init(repositoryDataSource: RepositoryDataSourceProtocol) {
        self.repositoryDataSource = repositoryDataSource
    }
    
    func viewDidLoad() {
        fetchExampleWithCombineAndSwiftConcurrency()
    }
}

// MARK: - Fetch
extension RepositoryListViewModel {
    
    /// example fetch with Combine only
    private func fetchExampleWithCombineOnly() {
        state = .loading
        repositoryDataSource.fetchRepositoriesWithCombine()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                case .finished:
                    self?.state = .finishedLoading
                }
            } receiveValue: { [weak self] items in
                self?.handleResponse(with: items)
            }
            .store(in: &cancellables)
    }
    
    /// example fetch with Combine and Swift Concurrency
    private func fetchExampleWithCombineAndSwiftConcurrency() {
        state = .loading
        Future<[RepositoryItem], Error> { promise in
            Task { [weak self] in
                do {
                    let items = try await self?.repositoryDataSource.fetchRepositoriesWithSwiftConcurrency()
                    promise(.success(items ?? []))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.state = .error(error.localizedDescription)
            case .finished:
                self?.state = .finishedLoading
            }
        } receiveValue: { [weak self] items in
            self?.handleResponse(with: items)
        }
        .store(in: &cancellables)
    }
    
    /// example fetch with Closure
    private func fetchExampleWithClosure() {
        state = .loading
        repositoryDataSource.fetchRepositoriesWithClosure { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let items):
                    self?.state = .finishedLoading
                    self?.handleResponse(with: items)
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    private func handleResponse(with items: [RepositoryItem]) {
        if let userName = items[safe: 0]?.owner.login {
            self.userName = userName.capitalized
        }
        self.items = items
    }
}
