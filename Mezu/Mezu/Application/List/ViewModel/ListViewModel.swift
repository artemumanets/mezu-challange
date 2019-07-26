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
    var photos = [Photo]()

    init(delegate: ListViewModelDelegate?, dataSource: FetcherProtocol = APIFetcher.default) {
        self.delegate = delegate
        self.dataSource = dataSource
    }

    func setupUI(viewController vc: ListViewController) {
        vc.title = AppData.shared.user.name
    }

    func populate(photoCell: PhotoPreviewCell, photo: Photo) {

        guard let url = photo.mediumSize?.url else {
            return
        }

        dataSource.fetchImageFrom(url: url) { (image) in
            UIView.transition(with: photoCell, duration: Animation.normal, options: .transitionCrossDissolve, animations: {
                photoCell.photoImageView.image = image
            })
        }
    }
}

extension ListViewModel {

    func fetchPhotos() {

        guard LoaderManager.shared.isLoading == false else {
            return
        }

        LoaderManager.shared.show()

        let request = FLRequestGetPublicPhotos(userId: AppData.shared.user.nsid, perPage: Configuration.Flickr.listPageSize, page: page)
        dataSource.fetch(request: request, onSuccess: { (response: FLResponseGetPublicPhotos) in

            self.fetchSizes(for: response.photos.photo, onSuccess: { (newPhotos) in
                self.page += 1
                self.photos += newPhotos
                self.delegate?.didUpdatePhotos()
            }, onError: {
                ErrorManager.show(description: "Error.NetworkGeneric".localized)
            }, onFinally: {
                LoaderManager.shared.hide()
            })
        }, onError: { error in
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
                }, onError: { error in
                    newPhotos.append(Photo(photo: photo, sizes: nil))
                    sequenceRequest.fail()
                })
            }
        })
        sequenceRequest.waitAll(onSuccess: {
            // Re-sort photos to the same order that was returned by the API
            newPhotos = newPhotos.sorted(by: { (photo1, photo2) -> Bool in
                guard let idx1 = (photos.firstIndex { $0.id == photo1.id }), let idx2 = (photos.firstIndex { $0.id == photo2.id }) else {
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
