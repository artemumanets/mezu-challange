//
//  DetailsViewModel.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsViewModelDelegate: class {

    func didFetchDetails()
}

class DetailsViewModel {

    weak var delegate: DetailsViewModelDelegate?
    private let dataSource: FetcherProtocol
    private var photo: Photo
    private var photoDetails: PhotoDetails?

    init(photo: Photo, delegate: DetailsViewModelDelegate?, dataSource: FetcherProtocol = APIFetcher.default) {
        self.photo = photo
        self.delegate = delegate
        self.dataSource = dataSource
    }

    func setupUI(viewController vc: DetailsViewController) {

        vc.titleLabel.set(color: R.Color.content, font: R.Font.heading, text: "Details.Title".localized)
        vc.descriptionTitleLabel.set(color: R.Color.content, font: R.Font.heading, text: "Details.Description".localized)
        vc.tagsTitleLabel.set(color: R.Color.content, font: R.Font.heading, text: "Details.Tags".localized)
        vc.titleValueLabel.set(color: R.Color.content, font: R.Font.content, text: "")
        vc.descriptionValueLabel.set(color: R.Color.content, font: R.Font.content, text: "")

        vc.numViewsTitleLabel.set(color: R.Color.content, font: R.Font.subheading, text: "Details.NumViews".localized)
        vc.dateTakenTitleLabel.set(color: R.Color.content, font: R.Font.subheading, text: "Details.DateTaken".localized)
        vc.dateUpdatedTitleLabel.set(color: R.Color.content, font: R.Font.subheading, text: "Details.DateUpdated".localized)
        vc.numViewsValueLabel.set(color: R.Color.subcontent, font: R.Font.subcontent, text: "")
        vc.dateTakenValueLabel.set(color: R.Color.subcontent, font: R.Font.subcontent, text: "")
        vc.dateUpdatedValueLabel.set(color: R.Color.subcontent, font: R.Font.subcontent, text: "")

        vc.photoImageView.layer.cornerRadius = R.Layout.cornerRadius
        vc.photoImageView.layer.masksToBounds = true

        vc.separators.forEach { $0.backgroundColor = R.Color.subcontent }
        vc.contentView.alpha = 0.0
    }

    func populateUI(viewController vc: DetailsViewController) {
        guard let photoDetails = self.photoDetails else {
            return
        }

        vc.titleValueLabel.text = photoDetails.title.capitalizedFirstLetter
        vc.descriptionValueLabel.text = photoDetails.description.capitalizedFirstLetter
        vc.dateTakenValueLabel.text = String(describing: photoDetails.dateTaken)
        vc.dateUpdatedValueLabel.text = String(describing: photoDetails.dateUpdated)
        vc.numViewsValueLabel.text = String(photoDetails.numberOfViews)

        let photoSize = R.Layout.Photo.newSize(for: photoDetails.photoSize?.size)
        vc.photoImageView.image = photoDetails.photo
        vc.photoWidthConstraint.constant = photoSize.width
        vc.photoHeightConstraint.constant = photoSize.height
        
        UIView.animate(withDuration: Animation.fast, animations: {
            vc.contentView.alpha = 1.0
        })
    }

    func fetchDetails() {
        guard LoaderManager.shared.isLoading == false else {
            return
        }

        let photo = self.photo
        var photoImage: UIImage!
        var photoInfo: FLInfoPhoto!
        let sequenceRequest = SequenceRequest()

        sequenceRequest
            .before { LoaderManager.shared.show() }
            .request { [ weak self] in
                self?.dataSource.fetch(request: FLRequestGetInfo(photoId: photo.id), onSuccess: { (response: FLResponseGetInfo) in
                    photoInfo = response.photo
                    sequenceRequest.success()
                }, onError: { _ in sequenceRequest.fail() })
            }.request { [weak self] in
                guard let url = photo.largeSize?.url else {
                    sequenceRequest.fail()
                    return
                }
                self?.dataSource.fetchImageFrom(url: url, onDidLoad: { (image) in
                    photoImage = image
                    sequenceRequest.success()
                })
            }.waitAll(onSuccess: { [weak self] in
                self?.photoDetails = PhotoDetails(photo: photo, photoInfo: photoInfo, photoImage: photoImage)
                self?.delegate?.didFetchDetails()
            }, onError: { ErrorManager.show(description: "Error.NetworkGeneric".localized) })
            .after { LoaderManager.shared.hide() }
    }
}