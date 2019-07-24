//
//  FLResponseGetPublicPhotos.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLResponseGetPublicPhotos: ResponseProtocol {

    let photos: FLPhotos
}

struct FLPhotos: ResponseProtocol {

    let page: Int
    let pages: Int
    let photo: [FLPhoto]
}

struct FLPhoto: ResponseProtocol {

    let id: String
    let title: String
}
