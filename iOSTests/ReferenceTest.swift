//
//  ReferenceTest.swift
//  iOSTests
//
//  Created by HS Lee on 2020/07/21.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import XCTest
import Umbrella
import RxSwift
import RxCocoa

@testable import iOS

class VCTest {
    let vc = UIViewController()
    let str = "test"
    let str2 = NSString(string: "test2")
    
    lazy var xx: () -> Void = { [str2] in //case4 - release, str2 is same addr
        print(str2.description)
        print(Unmanaged.passUnretained(str2).toOpaque())
//    lazy var xx: () -> Void = { [vc] in //case1 - release
//        print(vc.description)
    //lazy var xx: () -> Void = { //case2 - not release
    //lazy var xx: () -> Void = { [weak self] in //case3 - release
        //guard let self = self else { return } //self memory address diff
    //    print(self.vc.description)
    }

//  case 1
//    <UIViewController: 0x7fc437f17c30>
//    <UIViewController: 0x7fc437f17c30>
//    <UIViewController: 0x7fc437f17c30>
    
//  case2
//    (lldb) po self
//    <VCTest: 0x6000007a7740>
//
//    (lldb) po self.vc
//    <UIViewController: 0x7fcb7f40db30>
//
//    (lldb) po self
//    <VCTest: 0x6000007a7740>
//
//    (lldb) po self.vc
//    <UIViewController: 0x7fcb7f40db30>
    
//  case 3
//    (lldb)po self
//    <VCTest: 0x60000230b900>
//    (lldb) po self.vc
//    <UIViewController: 0x7fa6f6e1a9f0>
//
//
//    (lldb) po self
//    ▿ Optional<VCTest>
//      ▿ some : <VCTest: 0x60000230b900>
//    (lldb) po self!.vc
//    <UIViewController: 0x7fa6f6e1a9f0>

    func run() {
        print(Unmanaged.passUnretained(str2).toOpaque())
        xx()
    }
    
    func run2() {
        let xxx: () -> Void = {//local closure #case1 - release
            print(self.vc.description)
        }
        xxx()
    }
    
    let disposeBag = DisposeBag()
    let obs = Observable.just(())
    let relay = BehaviorRelay<Void>(value: ())
    func run3() {
        //Observable.just(()) - //case1 - deinit
        obs
            .subscribe(onNext: {//case2 - deinit
                print(self.vc.description)
            })
            .disposed(by: disposeBag)
        
        
        obs
            .subscribe(onNext: {//case2 - deinit
                print(self.vc.description)
            })
            .disposed(by: disposeBag)
    }
    
    func run4() {
        relay
//        .subscribe(onNext: {//case1 - not deinit
//        .subscribe(onNext: { [vc] in //case2 - not deinit
//            print(vc.description) //same addr
            .subscribe(onNext: {[weak self, vc] in //case3 - deinit - recommended
                guard let self = self else { return }
                print(vc.description) //same addr
                print(self.vc.description) //same addr
            })
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("\(NSStringFromClass(type(of: self))) deinit")
    }
}

class Person2 {
    var name: String
    
    lazy var greeting: String = {
        return "Hello my name is \((self.name))"
    }()
  
    init(name: String) {
        self.name = name
    }
    
    deinit {
        #if DEBUG
        print("\(NSStringFromClass(type(of: self))) deinit")
        #endif
    }
}

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    unowned var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}


class ReferenceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        var test: VCTest! = VCTest()
        //test.run()
        //test.run2()
        //test.run3()
        test.run4()
        test = nil
    }
    
    func test2() {
        var person: Person2! = Person2(name: "jack")
        print(person.greeting)
        person = nil
    }
    
    func test3() {
        var john: Person?
        var unit4A: Apartment?

        john = Person(name: "John Appleseed")
        unit4A = Apartment(unit: "4A")

        john!.apartment = unit4A
        unit4A!.tenant = john
        
        unit4A = nil
        john = nil
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
