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

    func setupUI(viewController vc: InitialViewController) {
        vc.infoLabel.set(color: R.Color.content, font: R.Font.content, text: "Initial.Info".localized)
        vc.infoButton.tintColor = R.Color.content

        vc.mezuLogoImageView.image = R.Image.mezuLogo.withRenderingMode(.alwaysTemplate)
        vc.mezuLogoImageView.tintColor = R.Color.content

        let searchIconImageView = UIImageView(image: R.Image.iconSearch.withRenderingMode(.alwaysTemplate))
        searchIconImageView.tintColor = R.Color.content
        vc.nameTextField.leftViewMode = .always
        vc.nameTextField.leftView = searchIconImageView
        vc.nameTextField.tintColor = R.Color.content
        vc.nameTextField.backgroundColor = R.Color.accent
        vc.nameTextField.set(placeholder: "Initial.Placeholder".localized,
                                         placeholderColor: R.Color.placeholder,
                                         textColor: R.Color.content,
                                         borderColor: R.Color.accent)

        // TODO: remove this
        vc.nameTextField.text = "eyetwist"
    }
}

extension InitalViewModel {

    func fetchUser(username: String) {

        let username = username.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        guard username.count > 0 else {
            ErrorManager.show(description: "Error.Initial.EmptyUsername".localized)
            return
        }
        guard LoaderManager.shared.isLoading == false else {
            return
        }

        LoaderManager.shared.show()

        dataSource.fetch(request: FLRequestFindByUserName(username: username), onSuccess: { (response: FLResponseFindByUserName) in

            self.delegate?.didFetch(user: User(response: response))
        }, onError: { (error: ServiceError<FLResponseError>) in

            let errorMessage = error.message(withFilter: { (apiError: FLResponseError) -> String? in
                return apiError.code == ErrorConstant.userNotFound.code ? ErrorConstant.userNotFound.message : nil
            })
            if let errorMessage = errorMessage {
                ErrorManager.show(description: errorMessage)
            } else {
                ErrorManager.show(error: error, retryCallback: {
                    self.fetchUser(username: username)
                })
            }
        }, onFinally: {
            LoaderManager.shared.hide()
        })
    }
}

private enum ErrorConstant {

    static let userNotFound: (code: Int, message: String) = (1, "Error.Initial.InvalidUsername".localized)
}
