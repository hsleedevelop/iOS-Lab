//
//  ProxiesTests.swift
//  PatternsTests
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import XCTest
@testable import Patterns

class ProxiesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProxies() throws {
        print("Client: Executing the client code with a real subject:")
        let realSubject = RealSubject()
        ClientProxies.clientCode(subject: realSubject)

        print("\nClient: Executing the same client code with a proxy:")
        let proxy = Proxy(realSubject)
        ClientProxies.clientCode(subject: proxy)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// Proxy Design Pattern
    ///
    /// Intent: Provide a surrogate or placeholder for another object to control
    /// access to the original object or to add other responsibilities.
    ///
    /// Example: There are countless ways proxies can be used: caching, logging,
    /// access control, delayed initialization, etc.

    func testProxyRealWorld() {

        print("Client: Loading a profile WITHOUT proxy")
        loadBasicProfile(with: Keychain())
        loadProfileWithBankAccount(with: Keychain())

        print("\nClient: Let's load a profile WITH proxy")
        loadBasicProfile(with: ProfileProxy())
        loadProfileWithBankAccount(with: ProfileProxy())
    }

    func loadBasicProfile(with service: ProfileService) {

        service.loadProfile(with: [.basic], success: { profile in
            print("Client: Basic profile is loaded")
        }) { error in
            print("Client: Cannot load a basic profile")
            print("Client: Error: " + error.localizedSummary)
        }
    }

    func loadProfileWithBankAccount(with service: ProfileService) {

        service.loadProfile(with: [.basic, .bankAccount], success: { profile in
            print("Client: Basic profile with a bank account is loaded")
        }) { error in
            print("Client: Cannot load a profile with a bank account")
            print("Client: Error: " + error.localizedSummary)
        }
    }

}
