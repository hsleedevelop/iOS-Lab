//
//  GithubJobsRepository.swift
//  Domain
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import RxSwift

public protocol GithubJobsRepository {
    func fetchJobs() -> Observable<[GithubJob]>
}
