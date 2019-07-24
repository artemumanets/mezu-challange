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
        self.backgroundColor = UIColor.red
        setupUI()
    }
    
    override func prepareForReuse() {

        setupUI()
    }

    func setupUI() {
        self.photoImageView.image = nil
        self.backgroundColor = R.Color.noImage
        self.layer.cornerRadius = R.Layout.List.cornerRadius
        self.layer.masksToBounds = true
        
    }
}
