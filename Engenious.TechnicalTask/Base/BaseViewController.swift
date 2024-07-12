//
//  BaseViewController.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import UIKit

struct NavigationBarSettings {
    var prefersLargeTitles = false
    var backgroundColor = UIColor.white
    var foregroundColor = UIColor.darkBlue
}

class BaseViewController: UIViewController {
    
    /// Convenience property for subclasses.
    /// If present it will be used to add view to hierarchy.
    var contentView: BaseView? {
        nil
    }
    
    var navigationBarSettings: NavigationBarSettings? {
        nil
    }
    
    private lazy var loadingContainer: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private lazy var contentUnavailableView: ContentUnavailableView = {
        let contentUnavailableView = ContentUnavailableView()
        contentUnavailableView.translatesAutoresizingMaskIntoConstraints = false
        return contentUnavailableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupVisual()
        setupNavigationBar()
    }
    
    private func setupUI() {
        if let contentView = contentView {
            view.addSubview(contentView)
        }
    }
    
    private func setupConstraints() {
        guard let contentView = contentView else { return }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupVisual() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        guard let navigationBarSettings = navigationBarSettings else { return }
        
        navigationController?.navigationBar.prefersLargeTitles = navigationBarSettings.prefersLargeTitles
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = navigationBarSettings.backgroundColor
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: navigationBarSettings.foregroundColor
        ]
        appearance.shadowColor = .clear
        appearance.largeTitleTextAttributes = [.foregroundColor: navigationBarSettings.foregroundColor]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

// MARK: - External functionality
extension BaseViewController {
    
    func showLoading() {
        guard loadingContainer.superview == nil else { return }
        
        if let navigationController = navigationController {
            navigationController.view.addSubview(loadingContainer)
            
            NSLayoutConstraint.activate([
                loadingContainer.topAnchor.constraint(equalTo: navigationController.view.topAnchor),
                loadingContainer.leadingAnchor.constraint(equalTo: navigationController.view.leadingAnchor),
                loadingContainer.bottomAnchor.constraint(equalTo: navigationController.view.bottomAnchor),
                loadingContainer.trailingAnchor.constraint(equalTo: navigationController.view.trailingAnchor)
            ])
        } else {
            view.addSubview(loadingContainer)
            
            NSLayoutConstraint.activate([
                loadingContainer.topAnchor.constraint(equalTo: view.topAnchor),
                loadingContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                loadingContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                loadingContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    
    func hideLoading() {
        loadingContainer.removeFromSuperview()
    }
    
    func showContentUnavailableView(onReloadButtonTapped: @escaping (() -> Void)) {
        guard contentUnavailableView.superview == nil else { return }
        
        view.addSubview(contentUnavailableView)
        NSLayoutConstraint.activate([
            contentUnavailableView.topAnchor.constraint(equalTo: view.topAnchor),
            contentUnavailableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentUnavailableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentUnavailableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        contentUnavailableView.onReloadButtonTapped = onReloadButtonTapped
    }
    
    func hideContentUnavailableView() {
        contentUnavailableView.removeFromSuperview()
    }
    
    func showAlert(title: String?, message: String?, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if !actions.isEmpty {
            actions.forEach(alertController.addAction)
        } else {
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
