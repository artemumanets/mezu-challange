//
//  FLRequestGetInfo.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLRequestGetInfo: RequestProtocol {

    var operation: APIOperation { return .getInfo(args) }

    private let args: [String: Any]

    init(photoId: String) {
        args = [Argument.photoId: photoId]
    }
}

private enum Argument {

    static let photoId = "photo_id"
}
