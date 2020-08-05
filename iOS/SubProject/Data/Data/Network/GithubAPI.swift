//
//  GithubAPI.swift
//  Data
//
//  Created by HS Lee on 2020/07/10.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation

enum GithubAPI: API {
    
    ///포토 리스트
    case list(Int, Int)
    ///검색
    case search(Int, Int, String)
    
    var path: String {
        switch self {
        case let .list(page, pageSize):
            return "/positions.json?description=ios&full_time=true"
        case let .search(page, pageSize, keyword):
            return "/search/photos?query=\(keyword)&page=\(page)"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
}
