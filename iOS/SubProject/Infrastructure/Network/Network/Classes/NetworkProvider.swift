//
//  NetworkService.swift
//  github-clean-mvvm
//
//  refer - Oleh Kudinov on 01.10.18.
//  Created by HS Lee on 2020/07/10.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import Data
import RxSwift

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case errorMessage(String?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

public protocol NetworkCancellable {
    func cancel()
}

public protocol NetworkErrorLogger {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}

class NetworkProvider: NetworkService {
    
    private let baseURL: String
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    /// API request
    /// moya concept을 빌려옴
    /// - Parameter api: api path generic
    /// - Returns: response date
    func request(api: API) -> Observable<Data> {
        guard let url = URL(string: baseURL + api.path) else {
            return Observable.error(NetworkError.urlGeneration)
        }
        #if DEBUG
        print("url=\(url)")
        #endif
        
        return Observable.create { observer in
            let request = NSMutableURLRequest(url: url)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if 200 ... 399 ~= statusCode {//서버의 응답 결과 정의 후 다양하게 처리 가능..
                        observer.onNext(data ?? Data())
                    } else {
                        observer.onError(NetworkError.errorMessage(HTTPURLResponse.localizedString(forStatusCode: statusCode)))
                    }
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
