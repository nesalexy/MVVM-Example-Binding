//
//  LoadingView.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 12.07.2024.
//

import Foundation
import UIKit

final class LoadingView: BaseView {
    
    private let activityIndicatorBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func setupUI() {
        super.setupUI()
        activityIndicatorBackground.addSubview(spinner)
        addSubview(activityIndicatorBackground)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            activityIndicatorBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorBackground.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorBackground.widthAnchor.constraint(equalToConstant: 90),
            activityIndicatorBackground.heightAnchor.constraint(equalToConstant: 90),
            
            spinner.centerXAnchor.constraint(equalTo: activityIndicatorBackground.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: activityIndicatorBackground.centerYAnchor)
        ])
    }
    
    override func setupVisuals() {
        super.setupVisuals()
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
}
