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

    private let dateTaken: Date?
    private let dateUpdated: Date?
    private let dateFormatter = DateFormatter(dateStyle: .medium)

    let title: String
    let description: String
    let numberOfViews: String
    let tags: [String]
    let photo: UIImage
    let photoSize: PhotoSize?

    let datePostedFormatted: String
    let dateUpdatedFormatted: String

    static let `default` = PhotoDetails()

    init(photo: Photo, photoInfo: FLInfoPhoto, photoImage: UIImage) {
        self.title = photoInfo.title.value.count == 0 ? R.Layout.Formatting.emptyString : photoInfo.title.value
        self.description = photoInfo.description.value.count == 0 ? R.Layout.Formatting.emptyString : photoInfo.description.value
        self.numberOfViews = photoInfo.views.count == 0 ? R.Layout.Formatting.emptyString : photoInfo.views
        self.tags = photoInfo.tags.tag.map { $0.raw }.sorted { $0.count < $1.count }
        self.photo = photoImage
        self.photoSize = photo.largeSize ?? photo.mediumSize

        if let postedTimestamp = Double(photoInfo.dates.posted) {
            self.dateTaken = Date(timeIntervalSince1970: postedTimestamp)
        } else {
            self.dateTaken = nil
        }

        if let updatedTimestamp = Double(photoInfo.dates.lastupdate) {
            self.dateUpdated = Date(timeIntervalSince1970: updatedTimestamp)
        } else {
            self.dateUpdated = nil
        }

        self.datePostedFormatted = dateFormatter.formattedString(from: dateTaken) ?? R.Layout.Formatting.emptyDate
        self.dateUpdatedFormatted = dateFormatter.formattedString(from: dateUpdated) ?? R.Layout.Formatting.emptyDate
    }

    private init() {
        self.title = ""
        self.description = ""
        self.numberOfViews = ""
        self.tags = [String]()
        self.photo = UIImage()
        self.photoSize = nil
        self.dateTaken = nil
        self.dateUpdated = nil
        self.datePostedFormatted = ""
        self.dateUpdatedFormatted = ""
    }
}
