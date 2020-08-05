//
//  DecoratorPatternTests.swift
//  PatternsTests
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import XCTest
@testable import Patterns

class DecoratorPatternTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecoratorConceptual() {
        // This way the client code can support both simple components...
        print("Client: I've got a simple component")
        let simple = ConcreteComponent()
        ClientDecorator.someClientCode(component: simple)

        // ...as well as decorated ones.
        //
        // Note how decorators can wrap not only simple components but the other
        // decorators as well.
        let decorator1 = ConcreteDecoratorA(simple)
        let decorator2 = ConcreteDecoratorB(decorator1)
        print("\nClient: Now I've got a decorated component")
        ClientDecorator.someClientCode(component: decorator2)
        
//        Client: I've got a simple component
//        Result: ConcreteComponent
//
//        Client: Now I've got a decorated component
//        Result: ConcreteDecoratorB(ConcreteDecoratorA(ConcreteComponent))
    }

}
