//
//  ListViewModel.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewModelDelegate: class {

    func didUpdatePhotos()
}

class ListViewModel: NSObject {

    weak var delegate: ListViewModelDelegate?
    private let dataSource: FetcherProtocol

    private var page = Configuration.Flickr.listFirstPage
    private var hasPages = true
    var photos = [Photo]()

    init(delegate: ListViewModelDelegate?, dataSource: FetcherProtocol = APIFetcher.default) {
        self.delegate = delegate
        self.dataSource = dataSource
    }

    func setupUI(viewController vc: ListViewController) {
        vc.title = AppData.shared.user.name
        vc.navigationItem.rightBarButtonItem = vc.closeButton
        vc.noContentLabel.set(color: R.Color.content, font: R.Font.content, text: "Error.List.NoPhotosToShow".localized)
        vc.noContentLabel.isHidden = true
    }

    func populate(photoCell: PhotoPreviewCell, photo: Photo) {

        guard let url = photo.mediumSize?.url else {
            return
        }
        photoCell.photo = photo

        dataSource.fetchImageFrom(url: url) { (image) in
            guard photoCell.photo?.id == photo.id else {
                return
            }
            UIView.transition(with: photoCell, duration: Animation.normal, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
                photoCell.photoImageView.image = image
            })
        }
    }

    func updateUI(viewController vc: ListViewController) {
        vc.collectionView.isHidden = (photos.count == 0)
        vc.noContentLabel.isHidden = !vc.collectionView.isHidden
    }
}

extension ListViewModel {

    func fetchPhotos() {

        guard hasPages && LoaderManager.shared.isLoading == false && ErrorManager.alertIsVisible == false else {
            return
        }

        LoaderManager.shared.show()

        let request = FLRequestGetPublicPhotos(userId: AppData.shared.user.nsid, perPage: Configuration.Flickr.listPageSize, page: page)
        dataSource.fetch(request: request, onSuccess: { (response: FLResponseGetPublicPhotos) in
            let photos: [FLPhoto] = response.photos.photo.filter { $0.media == Constant.mediaType }
            self.fetchSizes(for: photos, onSuccess: { (newPhotos) in
                self.page += 1
                self.photos += newPhotos
                self.hasPages = self.page <= response.photos.pages
                self.delegate?.didUpdatePhotos()
            }, onError: {
                ErrorManager.show(description: "Error.NetworkGeneric".localized)
            }, onFinally: {
                LoaderManager.shared.hide()
            })
        }, onError: { (error: ServiceError<FLResponseError>) in
            LoaderManager.shared.hide()
            ErrorManager.show(error: error, retryCallback: {
                self.fetchPhotos()
            })
        })
    }

    private typealias FetchSizesSuccessCallback = ([Photo]) -> ()
    private typealias FetchSizesErrorCallback = () -> ()
    private typealias FetchSizesFinallyCallback = () -> ()
    private func fetchSizes(for photos: [FLPhoto], onSuccess: @escaping FetchSizesSuccessCallback,
                            onError: @escaping FetchSizesErrorCallback,
                            onFinally: @escaping FetchSizesFinallyCallback) {
        var newPhotos = [Photo]()
        let sequenceRequest = SequenceRequest()
        photos.forEach({ [weak self] photo in
            sequenceRequest.request {
                self?.dataSource.fetch(request: FLRequestGetSizes(photoId: photo.id), onSuccess: { (response: FLResponseGetSizes) in
                    newPhotos.append(Photo(photo: photo, sizes: response.sizes.size))
                    sequenceRequest.success()
                }, onError: { (error: ServiceError<FLResponseError>) in
                    newPhotos.append(Photo(photo: photo, sizes: nil))
                    sequenceRequest.fail()
                })
            }
        })
        sequenceRequest.waitAll(onSuccess: {
            // Re-sort photos to the same order that was returned by the API
            newPhotos = newPhotos.sorted(by: { (photo1, photo2) -> Bool in
                guard let idx1 = (photos.firstIndex { $0.id == photo1.id }),
                    let idx2 = (photos.firstIndex { $0.id == photo2.id }) else {
                    return false
                }
                return idx1 < idx2
            })
            onSuccess(newPhotos)
            onFinally()
        }, onError: {
            onError()
            onFinally()
        })
    }
}

private enum Constant {

    static let mediaType: String = "photo"
}
