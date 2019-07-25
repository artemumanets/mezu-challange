//
//  FLResponseGetInfo.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLResponseGetInfo: ResponseProtocol {

    let photo: FLInfoPhoto
}

struct FLInfoPhoto: ResponseProtocol {

    let title: FLInfoTitle
    let description: FLInfoDescription
    let dates: FLInfoDates
    let views: String
    let tags: FLInfoTags
}

struct FLInfoTitle: ResponseProtocol {
    let value: String

    enum CodingKeys: String, CodingKey {
        case value = "_content"
    }
}

struct FLInfoDescription: ResponseProtocol {
    let value: String

    enum CodingKeys: String, CodingKey {
        case value = "_content"
    }
}

struct FLInfoDates: ResponseProtocol {
    let posted: String
    let lastupdate: String
}

struct FLInfoTags: ResponseProtocol {
    let tag: [FLInfoTag]
}

struct FLInfoTag: ResponseProtocol {
    let id: String
    let raw: String
}
