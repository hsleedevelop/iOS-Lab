//
//  LabItemsRepository.swift
//  Domain
//
//  Created by HS Lee on 2020/08/04.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import RxSwift

public protocol LabItemsRepository {
    func fetchLabItems() -> Observable<[LabItem]?>
}
