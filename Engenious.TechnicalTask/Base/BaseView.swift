//
//  BaseView.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import UIKit

class BaseView: UIView {
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        setupVisuals()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Method responsible for adding subviews.
    func setupUI() {}
    
    /// Method responsible for defining constraints between different subviews.
    func setupConstraints() {}
    
    /// Method responsible for look setup (colors, etc.)
    func setupVisuals() {}
}
