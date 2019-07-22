//
//  UITableViewReusable+Extension.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import UIKit

public protocol ReusableView: class {

    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

public extension ReusableView {

    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: self.reuseIdentifier, bundle: nil) }
}

extension UIView: ReusableView { }

public extension UITableView {

    func registerNib<T: UITableViewCell>(for cellClass: T.Type, in bundle: Bundle? = nil) {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UITableViewCell>(_ cellClass: T.Type) {

        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) {
        register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func registerHeaderFooterNib<T: UIView>(_ cellClass: T.Type, in bundle: Bundle? = nil) {
        register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func reusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func reusableHeaderFooter<T: UITableViewHeaderFooterView>(for section: Int) -> T {
    
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
    
    func cell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        
        return self.cellForRow(at: indexPath) as! T
    }
}
