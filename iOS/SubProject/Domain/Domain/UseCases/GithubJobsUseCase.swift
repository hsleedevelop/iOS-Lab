//
//  GithubJobsUseCase.swift
//  Domain
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import RxSwift

public protocol GithubJobsUseCase {
    func lists(page: Int) -> Observable<[GithubJob]>
//    func save(post: Post) -> Observable<Void>
//    func delete(post: Post) -> Observable<Void>
}

public final class GithubJobsUseCaseImpl: GithubJobsUseCase {
    
    private let githubJobsRepository: GithubJobsRepository

    public init(githubJobsRepository: GithubJobsRepository) {
        self.githubJobsRepository = githubJobsRepository
    }

    public func lists(page: Int) -> Observable<[GithubJob]> {
        return githubJobsRepository.fetchJobs()
    }
}
