//
//  API.swift
//  Data
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation

public protocol API {
    var path: String { get }
    var method: String { get }
}
