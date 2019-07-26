//
//  InfoViewController.swift
//  Mezu
//
//  Created by Artem Umanets on 26/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController: ViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mezuLogoImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thankYouLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    lazy var closeButton = UIBarButtonItem(image: R.Image.buttonClose, style: .plain, target: self, action: #selector(closeButtonTapped))

    private lazy var viewModel = InfoViewModel(model: InfoModel.default)

    convenience init() {
        self.init(type: InfoViewController.self)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.setupUI(viewController: self)

        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
    }

    @objc func appDidEnterBackground() {
        self.dismiss(animated: false)
    }
}
