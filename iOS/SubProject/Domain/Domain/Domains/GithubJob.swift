//
//  GithubJob.swift
//  Domain
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation

public struct GithubJob: Equatable, Identifiable {
    public let id, type: String
    public let url: String
    public let createdAt, company: String
    public let companyUrl: String?
    public let location, title, jobDescription: String
    public let howToApply: String?
    public let companyLogo: String?

    enum CodingKeys: String, CodingKey {
        case id, type, url
        case createdAt = "created_at"
        case company
        case companyUrl = "company_url"
        case location, title
        case jobDescription = "description"
        case howToApply = "how_to_apply"
        case companyLogo = "company_logo"
    }
    
    
    public init(id: String, type: String, url: String, createdAt: String, company: String, companyUrl: String?,
         location: String, title: String , jobDescription: String, howToApply: String?, companyLogo: String?) {
        self.id = id
        self.type = type
        self.url = url
        self.createdAt = createdAt
        self.company = company
        self.companyUrl = companyUrl
        self.location = location
        self.title = title
        self.jobDescription = jobDescription
        self.howToApply = howToApply
        self.companyLogo = companyLogo
    }
}
