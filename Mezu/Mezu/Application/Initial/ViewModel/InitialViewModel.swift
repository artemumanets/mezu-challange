//
//  InitialViewModel.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation
import UIKit

protocol InitalViewModelDelegate: class {
    func didFetch(user: User)
}

class InitalViewModel: NSObject {

    weak var delegate: InitalViewModelDelegate?
    private let dataSource: FetcherProtocol

    init(delegate: InitalViewModelDelegate, dataSource: FetcherProtocol = APIFetcher.default) {

        self.delegate = delegate
        self.dataSource = dataSource
    }

    func setupUI(viewController: InitialViewController) {
        viewController.infoLabel.set(color: R.Color.content, font: R.Font.content, text: "Initial.Info".localized)

        viewController.nameTextField.delegate = self
        viewController.nameTextField.tintColor = R.Color.accent
        viewController.nameTextField.backgroundColor = R.Color.background
        viewController.nameTextField.set(placeholder: "Initial.Placeholder".localized,
                                         placeholderColor: R.Color.placeholder,
                                         textColor: R.Color.content,
                                         borderColor: R.Color.accent)

        // TODO: remove this
        viewController.nameTextField.text = "eyetwist"
    }
}

extension InitalViewModel: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        fetchUser(username: textField.text ?? "")
        return true
    }
}

extension InitalViewModel {

    func fetchUser(username: String) {

        guard LoaderManager.shared.isLoading == false else {
            return
        }

        LoaderManager.shared.show()

        dataSource.fetch(request: FLRequestFindByUserName(username: username), onSuccess: { (response: FLResponseFindByUserName) in
            self.delegate?.didFetch(user: User(response: response))
        }, onError: { error in
            // TODO: Distinguish retry callback errors
            ErrorManager.show(error: error, retryCallback: {
                self.fetchUser(username: username)
            })
        }, onFinally: {
            LoaderManager.shared.hide()
        })
    }
}
