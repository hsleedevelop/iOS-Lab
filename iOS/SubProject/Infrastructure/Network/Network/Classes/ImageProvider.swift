//
//  ImageProvider.swift
//  AppStoreSearch
//
//  Created by HS Lee on 2020/07/26.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public protocol ImageProviding {
     func get(_ urlString: String) -> Observable<UIImage>
}

public class ImageProvider: ImageProviding {
    static let urlCache: URLCacheImageProvider = URLCacheImageProvider()
    static let nsCache: NSCacheImageProvider = NSCacheImageProvider()
    
    public class var shared: ImageProvider {
        return Self.urlCache
    }
    
    public func get(_ urlString: String) -> Observable<UIImage> {
        return .empty()
    }
}
