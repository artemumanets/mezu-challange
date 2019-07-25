//
//  PhotoDetails.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

struct PhotoDetails {

    let title: String
    let description: String
    let dateTaken: Date
    let dateUpdated: Date
    let numberOfViews: Int
    let tags: [String]
    let photo: UIImage
    let photoSize: PhotoSize?

    init(photo: Photo, photoInfo: FLInfoPhoto, photoImage: UIImage) {
        self.title = photoInfo.title.value
        self.description = photoInfo.description.value
        self.dateTaken = Date()
        self.dateUpdated = Date()
        self.numberOfViews = Int(photoInfo.views) ?? 0
        self.tags = photoInfo.tags.tag.map { $0.raw }
        self.photo = photoImage
        self.photoSize = photo.largeSize ?? photo.mediumSize
    }
}
