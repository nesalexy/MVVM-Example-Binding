//
//  RepositoryListCell.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import UIKit

final class RepositoryListCell: BaseTableViewCell {
    
    private lazy var rootView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.edgeInsets(topSpacing: 16, bottomSpacing: 16, leadingSpacing: 16, trailingSpacing: 16)
        stackView.radius(radius: 8)
        stackView.spacing = 8
        stackView.backgroundColor = UIColor.iceberg
        stackView.shadow(opacity: 0.1)
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textColor = UIColor.frenchBlue
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.textColor = UIColor.darkCerulean
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        
        rootView.addArrangedSubviews([
            titleLabel,
            descriptionLabel
        ])
        addSubview(rootView)
    }
    
    override func setupVisuals() {
        super.setupVisuals()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        rootView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: RepositoryListView.Constants.leading),
            rootView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: RepositoryListView.Constants.trailing),
            rootView.topAnchor.constraint(equalTo: topAnchor),
            rootView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - Fill
extension RepositoryListCell {
    func fill(with item: RepositoryItem) {
        titleLabel.text = item.name
        descriptionLabel.text = item.description
    }
}
