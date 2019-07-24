//
//  FLRequestGetPublicPhotos.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLRequestGetPublicPhotos: RequestProtocol {

    var operation: APIOperation { return .getPublicPhotos(args) }

    private let args: [String: Any]

    init(userId: String, perPage: Int, page: Int) {
        args = [Argument.userId: userId,
                Argument.perPage: perPage,
                Argument.page: page]
    }
}

private enum Argument {

    static let userId = "user_id"
    static let perPage = "per_page"
    static let page = "page"
}
