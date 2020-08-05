//
//  NetworkService.swift
//  Data
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import RxSwift

public protocol NetworkService {
    func request(api: API) -> Observable<Data>
}
