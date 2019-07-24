//
//  InitialViewController.swift
//  Mezu
//
//  Created by Artem Umanets on 22/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: ViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    private lazy var viewModel = InitalViewModel(delegate: self)

    convenience init() {
        self.init(type: InitialViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.setupUI(viewController: self)
    }
}

extension InitialViewController: InitalViewModelDelegate {

    func didFetch(user: User) {
        AppData.shared.user = user
        Router.modal(from: self, to: .list)
    }
}
