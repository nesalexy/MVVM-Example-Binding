//
//  UITableView+Extension.swift
//  Engenious.TechnicalTask
//
//  Created by Alexy Nesterchuk on 11.07.2024.
//

import Foundation
import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableCell {}
extension ReusableCell where Self: UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
}

extension UITableView {
    func register<T: UITableViewCell>(item: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func deque<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
