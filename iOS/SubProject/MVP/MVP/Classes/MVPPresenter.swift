//
//  MVPPresenter.swift
//  MVP
//
//  Created by HS Lee on 2020/08/06.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import Domain

import RxSwift
import RxCocoa

protocol MVPPresenterView: class {
    func updateFetchedGithubJobs(jobsObs: Observable<[GithubJob]>)
}

final class MVPPresenter {
   
    // MARK: - * Dependencis 💉 --------------------
    var githubJobsUseCase: GithubJobsUseCase?
    weak var view: MVPPresenterView?
    
    // MARK: - * Properties --------------------
    private let disposeBag = DisposeBag()
    
    init(githubJobsUseCase: GithubJobsUseCase, view: MVPPresenterView) {
        self.githubJobsUseCase = githubJobsUseCase
        self.view = view
    }
    
    func fetchGithubJobs(page: Int) {
        githubJobsUseCase?.lists(page: page)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] jobs in
                self?.view?.updateFetchedGithubJobs(jobsObs: .just(jobs))
            })
            .disposed(by: disposeBag)
    }
}
