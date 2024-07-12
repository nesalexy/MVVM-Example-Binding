//
//  BaseTableViewCell.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import UIKit

class BaseTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.isUserInteractionEnabled = true
        
        setupUI()
        setupVisuals()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {}
    
    func setupVisuals() {}
    
    func setupConstraints() {}
}
