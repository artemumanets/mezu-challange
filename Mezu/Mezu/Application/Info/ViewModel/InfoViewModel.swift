//
//  InfoViewModel.swift
//  Mezu
//
//  Created by Artem Umanets on 26/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

struct InfoViewModel {


    private let model: InfoModel

    init(model: InfoModel) {
        self.model = model
    }

    func setupUI(viewController vc: InfoViewController) {
        vc.title = "Info.Title".localized
        vc.navigationItem.rightBarButtonItem = vc.closeButton

        vc.titleLabel.set(color: R.Color.content, font: R.Font.heading, text: "Info.ChallangeInfo".localized)
        vc.nameLabel.set(color: R.Color.content, font: R.Font.heading, text: model.name)
        vc.descriptionLabel.set(color: R.Color.content, font: R.Font.content, text: model.description)
        vc.thankYouLabel.set(color: R.Color.subcontent, font: R.Font.subcontent, text: "Info.ThankYou".localized)
        vc.separatorView.backgroundColor = R.Color.subcontent
        
        vc.mezuLogoImageView.image = model.mezuLogo.withRenderingMode(.alwaysTemplate)
        vc.mezuLogoImageView.tintColor = R.Color.content

        vc.photoImageView.image = model.photo
    }
}
