//
//  PhotoPreviewCell.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class PhotoPreviewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    override func prepareForReuse() {

        setupUI()
    }

    func setupUI() {
        self.photoImageView.image = nil
        self.contentView.backgroundColor = R.Color.noImage
        self.contentView.layer.cornerRadius = R.Layout.List.cornerRadius
        self.contentView.layer.masksToBounds = true
        setSelected(state: false, animated: false)
    }

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        } set {
            super.isHighlighted = newValue
            setSelected(state: newValue, animated: true)
        }
    }

    override var isSelected: Bool {
        get {
            return super.isSelected
        } set {
            super.isSelected = newValue
            setSelected(state: newValue, animated: true)
        }
    }

    private func setSelected(state: Bool, animated: Bool) {

        let changeSelectedState: () -> () =  {
            self.contentView.transform = CGAffineTransform.identity.scaledBy(x: state ? 0.95 : 1.0, y: state ? 0.95 : 1.0)
            self.contentView.alpha = state ? 0.7 : 1.0
        }

        if animated {
            UIView.animate(withDuration: Animation.fast, animations: changeSelectedState)
        } else {
            changeSelectedState()
        }
    }
}
