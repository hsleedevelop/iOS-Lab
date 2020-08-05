//
//  GithubJobsRepositoryImpl.swift
//  Data
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Domain
import RxSwift
import RxSwiftExt

public final class GithubJobsRepositoryImpl {
    typealias T = GithubAPI
    private let service: NetworkService
    
    public init(service: NetworkService) {
        self.service = service
    }
}

extension GithubJobsRepositoryImpl: GithubJobsRepository {
    public func fetchJobs() -> Observable<[GithubJob]> {
        return service.request(api: T.list(0, 0))
        .map([JobElementDTO].self)
        .mapMany { $0.toDomain() }
    }
}
