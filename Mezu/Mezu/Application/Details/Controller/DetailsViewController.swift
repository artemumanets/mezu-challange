//
//  DetailsViewController.swift
//  Mezu
//
//  Created by Artem Umanets on 23/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: ViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleValueLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionValueLabel: UILabel!
    @IBOutlet weak var numViewsTitleLabel: UILabel!
    @IBOutlet weak var numViewsValueLabel: UILabel!
    @IBOutlet weak var dateTakenTitleLabel: UILabel!
    @IBOutlet weak var dateTakenValueLabel: UILabel!
    @IBOutlet weak var dateUpdatedTitleLabel: UILabel!
    @IBOutlet weak var dateUpdatedValueLabel: UILabel!
    @IBOutlet weak var tagsTitleLabel: UILabel!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet var separators: [UIView]!
    
    private var viewModel: DetailsViewModel!

    convenience init(photo: Photo) {
        self.init(type: DetailsViewController.self)
        viewModel = DetailsViewModel(photo: photo, delegate: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.setupUI(viewController: self)
        viewModel.fetchDetails()
    }
}

extension DetailsViewController: DetailsViewModelDelegate {

    func didFetchDetails() {
        viewModel.populateUI(viewController: self)
    }
}
