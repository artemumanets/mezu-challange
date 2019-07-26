//
//  ListViewController.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: ViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noContentLabel: UILabel!
    lazy var closeButton = UIBarButtonItem(image: R.Image.buttonClose, style: .plain, target: self, action: #selector(closeButtonTapped))

    private lazy var viewModel = ListViewModel(delegate: self)

    convenience init() {
        self.init(type: ListViewController.self)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.setupUI(viewController: self)

        collectionView.registerNib(for: PhotoPreviewCell.self)
        viewModel.fetchPhotos()

        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
    }

    @objc func appDidEnterBackground() {
        self.dismiss(animated: false)
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoPreviewCell = collectionView.dequeueReusableCell(for: indexPath)
        let photo = viewModel.photos[indexPath.row]
        viewModel.populate(photoCell: cell, photo: photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedPhoto = viewModel.photos[indexPath.row]
        Router.push(from: self, to: .details(selectedPhoto))
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: R.Layout.margin, left: R.Layout.margin, bottom: R.Layout.margin, right: R.Layout.margin)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return R.Layout.margin
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return R.Layout.Photo.newSize(for: viewModel.photos[indexPath.row].mediumSize?.size)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
            viewModel.fetchPhotos()
        }
    }
}

extension ListViewController: ListViewModelDelegate {

    func didUpdatePhotos() {
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        viewModel.updateUI(viewController: self)
    }
}
