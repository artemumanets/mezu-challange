//
//  TagCell.swift
//  Mezu
//
//  Created by Artem Umanets on 25/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class TagCell: UICollectionViewCell {

    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var labelHolderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    override func prepareForReuse() {

        self.tagNameLabel.text = ""
    }

    func setupUI() {
        self.contentView.backgroundColor = UIColor.clear
        self.tagNameLabel.set(color: R.Color.content, font: R.Font.smallcontent)
        self.labelHolderView.backgroundColor = R.Color.accent
        self.labelHolderView.layer.cornerRadius = R.Layout.cornerRadius
        self.labelHolderView.layer.masksToBounds = true
    }
}
