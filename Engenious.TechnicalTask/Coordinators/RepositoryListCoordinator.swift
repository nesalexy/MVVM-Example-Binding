//
//  RepositoriesCoordinator.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import UIKit

protocol RepositoryListCoordinatorProtocol {
    func launchRepositories()
}

final class RepositoryListCoordinator: RepositoryListCoordinatorProtocol {
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func launchRepositories() {
        // change it to Swinject
        let repositoryDataSource: RepositoryDataSourceProtocol = RepositoryDataSource(client: URLSession.shared)
        let viewController = RepositoryListViewController(viewModel: RepositoryListViewModel(repositoryDataSource: repositoryDataSource))
        navigationController.pushViewController(viewController, animated: false)
    }
}
