//
//  Photo.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

struct PhotoSize {
    let url: URL
    let size: CGSize

    init(url: URL, width: Int, height: Int) {
        self.url = url
        self.size = CGSize(width: width, height: height)
    }
}

struct Photo {
    let id: String
    let title: String

    let mediumSize: PhotoSize?
    let largeSize: PhotoSize?

    init(photo: FLPhoto, sizes: [FLSize]?) {
        self.id = photo.id
        self.title = photo.title

        if let mediumSize = (sizes?.first { $0.label == FLSizeLabel.medium640.rawValue }) ?? sizes?.first,
            let mediumUrl = URL(string: mediumSize.source) {
            self.mediumSize = PhotoSize(url: mediumUrl, width: mediumSize.width, height: mediumSize.height)
        } else {
            self.mediumSize = nil
        }

        if let largeSize = (sizes?.first { $0.label == FLSizeLabel.large1600.rawValue }) ?? sizes?.first,
            let largeUrl = URL(string: largeSize.source) {
            self.largeSize = PhotoSize(url: largeUrl, width: largeSize.width, height: largeSize.height)
        } else {
            self.largeSize = nil
        }
    }
}
