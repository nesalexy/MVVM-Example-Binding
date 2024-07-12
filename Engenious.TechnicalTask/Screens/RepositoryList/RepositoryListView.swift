//
//  RepositoryListView.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import UIKit

final class RepositoryListView: BaseView {
    
    // MARK: - Constants
    struct Constants {
        static let title: String = "Repositories"
        static let leading: CGFloat = 20.5
        static let trailing: CGFloat = -20.5
    }
    
    // MARK: - UI
    lazy var tableHeaderView: UIView = {
        let tableHeaderView = UIView()
        tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.isHidden = true
        return tableHeaderView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.frenchBlue
        label.text = Constants.title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var emptyListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.frenchBlue
        label.text = "List is empty"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()

    
    // MARK: - Property
    private var items = [RepositoryItem]()
    
    override func setupUI() {
        super.setupUI()
        /// setup header for list
        tableHeaderView.addSubview(titleLabel)
        
        addSubviews([
            tableView,
            emptyListLabel
        ])
        
        setupTableView()
        setupTableHeaderView()
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyListLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyListLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: Constants.leading),
            titleLabel.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: Constants.trailing),
            titleLabel.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor, constant: -16)
        ])
    }
}

//MARK: - Fill
extension RepositoryListView {
    func fill(with items: [RepositoryItem]) {
        print("fill")
        /// setup items to list
        self.items = items
        tableView.reloadData()
        
        emptyListLabel.isHidden = !self.items.isEmpty
        tableHeaderView.isHidden = self.items.isEmpty
    }
}

//MARK: - Setup TableView
extension RepositoryListView {
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(item: RepositoryListCell.self)
    }
    
    private func setupTableHeaderView() {
        tableView.tableHeaderView = tableHeaderView
    }
}

//MARK: - TableView delegate
extension RepositoryListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryListCell = tableView.deque(for: indexPath)
        cell.fill(with: items[indexPath.row])
        return cell
    }
}
