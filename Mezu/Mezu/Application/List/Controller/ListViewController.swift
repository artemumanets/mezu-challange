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

    lazy var viewModel = ListViewModel(delegate: self)

    convenience init() {
        self.init(type: ListViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = AppData.shared.user.name

        collectionView.registerNib(for: PhotoPreviewCell.self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        viewModel.fetchPhotos()
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

        Router.push(from: self, to: .details)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: R.Layout.List.space, left: R.Layout.List.space, bottom: R.Layout.List.space, right: R.Layout.List.space)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return R.Layout.List.space
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        let expectedWidth = UIScreen.main.bounds.width - inset.left - inset.right

        guard let mediumSize = viewModel.photos[indexPath.row].mediumSize else {
            return CGSize(width: expectedWidth, height: UIScreen.main.bounds.width * 0.65)
        }

        let expectedHeight = expectedWidth * mediumSize.size.height / mediumSize.size.width
        return CGSize(width: expectedWidth, height: expectedHeight)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
//            performRequest(query: searchBar.query, page: page)
//        }
    }
}

extension ListViewController: ListViewModelDelegate {

    func didUpdatePhotos() {
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
