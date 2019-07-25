//
//  FLResponseGetSizes.swift
//  Mezu
//
//  Created by Artem Umanets on 24/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

struct FLResponseGetSizes: ResponseProtocol {

    let sizes: FLSizes
}

struct FLSizes: ResponseProtocol {

    let size: [FLSize]
}

struct FLSize: ResponseProtocol {

    let label: String
    let source: String
    let media: String
    let width: Int
    let height: Int

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            label = try container.decode(String.self, forKey: .label)
            source = try container.decode(String.self, forKey: .source)
            media = try container.decode(String.self, forKey: .media)

            if let width = (try? container.decode(String.self, forKey: .width)) {
                self.width = Int(width) ?? 0
            } else {
                self.width = try container.decode(Int.self, forKey: .width)
            }

            if let height = (try? container.decode(String.self, forKey: .height)) {
                self.height = Int(height) ?? 0
            } else {
                self.height = try container.decode(Int.self, forKey: .height)
            }
        }
    }
}

enum FLSizeLabel: String {

    case square = "Square"
    case largeSquare = "Large Square"
    case thumbnail = "Thumbnail"
    case small = "Small"
    case small320 = "Small 320"
    case medium = "Medium"
    case medium640 = "Medium 640"
    case medium800 = "Medium 800"
    case large = "Large"
    case large1600 = "Large 1600"
    case large2048 = "Large 2048"
    case original = "Original"
}
