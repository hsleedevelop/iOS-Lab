//
//  MainViewModel.swift
//  iOS
//
//  Created by HS Lee on 2020/08/04.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa
import RxSwiftExt

final class MainViewModel: ViewModelType {
    
    // MARK: - * Properties  --------------------
    let flowRelay = PublishRelay<MainCoordinator.Flow>()
    
    // MARK: - * Dependencies --------------------
    
    // MARK: - * private --------------------
    private let disposeBag = DisposeBag()
    private let labItemListUseCase: LabItemListUseCase
    
    init(labItemListUseCase: LabItemListUseCase) {
        self.labItemListUseCase = labItemListUseCase
    }
    
    func transform(input: Input) -> Output {
        
        let items = input.fetchLabItems
            .flatMap ({ [weak self] _ -> Observable<[LabItem]?> in
                guard let self = self else { return Observable<[LabItem]?>.empty() }
                return self.labItemListUseCase.execute()
            })
            .unwrap()
        
//        Observable.merge(searchTermObs, searchObs, searchCancelObs)
//            .bind(to: flowRelay)
//            .disposed(by: disposeBag)

        return .init(fetchedLabItems: items.asDriver(onErrorJustReturn: []))
    }
    
    deinit {
        logD("\(NSStringFromClass(type(of: self))) deinit")
    }
}

extension MainViewModel {
    struct Input {
        let fetchLabItems: Observable<Void>
    }
    
    struct Output {
        let fetchedLabItems: Driver<[LabItem]>
    }
}

