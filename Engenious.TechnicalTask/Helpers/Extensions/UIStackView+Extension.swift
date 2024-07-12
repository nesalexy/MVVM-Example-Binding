//
//  UIStackView+Extension.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
    
    func edgeInsets(topSpacing: CGFloat = 0,
                    bottomSpacing: CGFloat = 0,
                    leadingSpacing: CGFloat = 0,
                    trailingSpacing: CGFloat = 0) {
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: topSpacing,
                                                           leading: leadingSpacing,
                                                           bottom: bottomSpacing,
                                                           trailing: trailingSpacing)
    }
    
    func border(borderColor: UIColor = .clear,
                borderWidth: CGFloat = 0,
                radius: CGFloat = 8) {
        if #available(iOS 14.0, *) {
            layer.borderWidth = borderWidth
            layer.cornerRadius = radius
            layer.borderColor = borderColor.cgColor
        } else {
            let subView = UIView(frame: bounds)
            subView.layer.cornerRadius = radius
            subView.layer.masksToBounds = true
            subView.layer.borderWidth = borderWidth
            subView.layer.borderColor = borderColor.cgColor
            subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            subView.radius(radius: radius)
            insertSubview(subView, at: 0)
        }
    }
}
