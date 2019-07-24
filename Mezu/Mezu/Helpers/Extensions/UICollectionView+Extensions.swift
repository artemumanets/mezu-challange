//
//  UICollectionView+Extensions.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

public protocol ReusableView: class {

    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

public extension ReusableView {

    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: self.reuseIdentifier, bundle: nil) }
}

extension UICollectionViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }

public protocol ModelPresenterCell {

    associatedtype Model
    var model: Model? { get set}
}

public extension UICollectionView {

    func registerNib<T: UICollectionViewCell>(for cellClass: T.Type, in bundle: Bundle? = nil) {

        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
