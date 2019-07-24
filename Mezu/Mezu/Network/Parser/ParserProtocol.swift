//
//  ParserProtocol.swift
//  Mezu
//
//  Created by Artem Umanets on 05/07/2019.
//  Copyright © 2019 Artem Umanets. All rights reserved.
//

import Foundation

protocol ParserProtocol {

    func parse<T: Decodable>(data: Data) throws -> T
}
