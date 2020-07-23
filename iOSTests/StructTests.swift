//
//  iOSTests.swift
//  iOSTests
//
//  Created by HS Lee on 2020/07/06.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import XCTest
@testable import iOS

struct STEST {
    let aaa: String
    var bbb: NSString
    
    init(aaa: String, bbb: NSString) {
        self.aaa = aaa
        self.bbb = bbb
    }
}

class STEST2 {
    let aaa: String
    var bbb: NSString
    
    init(aaa: String, bbb: NSString) {
        self.aaa = aaa
        self.bbb = bbb
    }
}

class StructTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        var test1 = STEST.init(aaa: "aaa", bbb: .init(string: "bbb"))
        var test2 = test1
        print(test1)
        print(test2)
        print(Unmanaged.passUnretained(test1.bbb).toOpaque())
        print(Unmanaged.passUnretained(test2.bbb).toOpaque()) //same
        
        test1.bbb = "bbb2"
        
        print(Unmanaged.passUnretained(test1.bbb).toOpaque()) //change
        print(Unmanaged.passUnretained(test2.bbb).toOpaque()) //same
        
        test2.bbb = "bbb3"
        
        print(Unmanaged.passUnretained(test1.bbb).toOpaque()) //same
        print(Unmanaged.passUnretained(test2.bbb).toOpaque()) //change
        
        test1.bbb = "bbb4"
        
        print(Unmanaged.passUnretained(test1.bbb).toOpaque()) //change
        print(Unmanaged.passUnretained(test2.bbb).toOpaque()) //same
    }
    
    func testExample2() throws {
        var test1 = STEST2.init(aaa: "aaa", bbb: .init(string: "bbb"))
        var test2 = test1
        print(test1)
        print(test2)
        print(Unmanaged.passUnretained(test1.bbb).toOpaque())
        print(Unmanaged.passUnretained(test2.bbb).toOpaque()) //1, 2 same
        
        test1.bbb = "bbb2" //change
        
        print(Unmanaged.passUnretained(test1.bbb).toOpaque())
        print(Unmanaged.passUnretained(test2.bbb).toOpaque()) //1, 2 same
        
        test2.bbb = "bbb3" //change
        
        print(Unmanaged.passUnretained(test1.bbb).toOpaque())
        print(Unmanaged.passUnretained(test2.bbb).toOpaque()) //1, 2 same
        
        test1.bbb = "bbb4" //change
        
        print(Unmanaged.passUnretained(test1.bbb).toOpaque())
        print(Unmanaged.passUnretained(test2.bbb).toOpaque()) //1, 2 same
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
