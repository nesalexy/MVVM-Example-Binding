//
//  ViewController.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import UIKit
import Combine

class RepositoryListViewController: BaseViewController {
    
    override var contentView: BaseView {
        repositoryListView
    }
    
    override var navigationBarSettings: NavigationBarSettings {
        .init(prefersLargeTitles: true)
    }
    
    private lazy var repositoryListView = RepositoryListView()
    
    private let viewModel: RepositoryListViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: RepositoryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setUpBindings()
    }
    
    private func setUpBindings() {
        // title
        viewModel.$userName
            .sink { [weak self] title in
                self?.title = title
            }
            .store(in: &subscriptions)
        
        // items
        viewModel.$items
            .dropFirst()
            .sink { [weak self] items in
                self?.repositoryListView.fill(with: items)
            }
            .store(in: &subscriptions)
        
        // view states
        let stateValueHandler: (RepositoryListViewModelState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.showLoading()
            case .finishedLoading:
                self?.hideLoading()
            case .error(let errorMsg):
                self?.hideLoading()
                self?.showAlert(title: "Error", message: errorMsg)
                /// show view with the ability to reload viewController
                self?.showContentUnavailableView { [weak self] in
                    self?.hideContentUnavailableView()
                    self?.viewModel.viewDidLoad()
                }
            }
        }
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &subscriptions)
    }
}

