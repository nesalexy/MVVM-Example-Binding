//
//  ContentUnavailableView.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

import Foundation
import UIKit


final class ContentUnavailableView: BaseView {
    
    var onReloadButtonTapped: (() -> Void)?
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Content Unavailable"
        return label
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reload", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func setupUI() {
        super.setupUI()
        stackView.addArrangedSubviews([
            messageLabel,
            reloadButton
        ])
        addSubview(stackView)
        
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func setupVisuals() {
        super.setupVisuals()
        backgroundColor = .white
    }
    
    @objc private func reloadButtonTapped() {
        onReloadButtonTapped?()
    }
    
}
