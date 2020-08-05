//
//  AppConfiguration.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 25.02.19.
//

import Foundation

final class AppConfiguration {
    static let shared = AppConfiguration()
    
    // MARK: - * Lazy Variable --------------------
    lazy var apiBaseURL: String = {
        return "https://jobs.github.com"
    }()
    
    lazy var appURLCache: URLCache = {
        let memoryCapacity = 20 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: 0, diskPath: nil)
        return urlCache
    }()
    
    // MARK: - * Setup --------------------
    func setupDefaultURLCache() {
        URLCache.shared = appURLCache
    }
}
