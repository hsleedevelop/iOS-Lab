//
//  LabItemListUseCase.swift
//  Domain
//
//  Created by HS Lee on 2020/08/04.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import RxSwift

//public protocol UseCase { //another way.
//    @discardableResult
//    func excute() -> Cancellable?
//}

public protocol LabItemListUseCase { //use case should move UseCase Framework? 🤔
    func execute() -> Observable<[LabItem]?>
}

public final class LabItemListUseCaseImpl: LabItemListUseCase {
    
    private let labItemsRepository: LabItemsRepository

    public init(labItemsRepository: LabItemsRepository) {
        self.labItemsRepository = labItemsRepository
    }

    public func execute() -> Observable<[LabItem]?> {
        return labItemsRepository.fetchLabItems()
    }
}
