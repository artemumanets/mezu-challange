//
//  InfoModel.swift
//  Mezu
//
//  Created by Artem Umanets on 26/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

struct InfoModel {

    let name: String
    let description: String
    let mezuLogo: UIImage
    let photo: UIImage

    static let `default`: InfoModel = InfoModel(name: "Info.DeveloperName".localized,
                                                description: "Info.DeveloperDescription".localized,
                                                mezuLogo: R.Image.mezuLogo,
                                                photo: R.Image.myPhoto)
    
    init(name: String, description: String, mezuLogo: UIImage, photo: UIImage) {
        self.name = name
        self.description = description
        self.mezuLogo = mezuLogo
        self.photo = photo
    }
}
