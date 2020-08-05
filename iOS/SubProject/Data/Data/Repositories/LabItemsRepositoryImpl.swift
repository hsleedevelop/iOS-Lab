//
//  LabItemsRepositoryImpl.swift
//  Data
//
//  Created by HS Lee on 2020/08/04.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class LabItemsRepositoryImpl {

//    private let dataTransferService: DataTransferService
//    private let cache: MoviesResponseStorage
//
//    init(dataTransferService: DataTransferService, cache: MoviesResponseStorage) {
//        self.dataTransferService = dataTransferService
//        self.cache = cache
//    }
    public init() {
        
    }
}

extension LabItemsRepositoryImpl: LabItemsRepository {
    
    public func fetchLabItems() -> Observable<[LabItem]?> {
        return Observable.create { observer -> Disposable in
            let items: [LabItem] = [.init(category: .architecture(.MVC)),
                                    .init(category: .architecture(.MVP)),
                                    .init(category: .architecture(.MVVM)),
                                    .init(category: .architecture(.MVVM_C)),
                                    .init(category: .architecture(.RIBs)),
                                    .init(category: .pattern(.Proxy)),
                                    .init(category: .pattern(.Decorator))]
            observer.onNext(items)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
