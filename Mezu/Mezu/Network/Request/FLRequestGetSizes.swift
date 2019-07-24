//
//  FLRequestGetSizes.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLRequestGetSizes: RequestProtocol {

    var operation: APIOperation { return .getSizes(args) }

    private let args: [String: Any]

    init(photoId: String) {
        args = [Argument.photoId: photoId]
    }
}

private enum Argument {

    static let photoId = "photo_id"
}
