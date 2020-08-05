//
//  CharactorDecoratorTests.swift
//  PatternsTests
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import XCTest
@testable import Patterns

class CharactorDecoratorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let orc = Orc()
        var hp = orc.getHealth() // 10
        
        let orcWarlord = Warlord(base: orc)
        hp = orcWarlord.getHealth() // 60
        
        let epicOrcWarlord = Epic(base: orcWarlord)
        hp = epicOrcWarlord.getHealth() // 90
        
        let doubleEpicOrcWarlord = Epic(base: epicOrcWarlord)
        hp = doubleEpicOrcWarlord.getHealth() // 120
        
        let elf = Elf()
        hp = elf.getHealth() // 5
        
        let elfWarlord = Warlord(base: elf)
        hp = elfWarlord.getHealth() // 55
        elfWarlord.battleCry() // "RAWR"
    }
}
