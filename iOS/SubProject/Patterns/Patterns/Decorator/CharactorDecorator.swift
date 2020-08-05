//
//  CharactorDecorator.swift
//  Patterns
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation

// Core Component
protocol Character {
    func getHealth() -> Int
}

// Concrete Components
struct Orc: Character {
    func getHealth() -> Int {
        return 10
    }
}

struct Elf: Character {
    func getHealth() -> Int {
        return 5
    }
}

// Decorator
protocol CharacterType: Character {
    var base: Character { get }
}

// Concrete Decorators
struct Warlord: CharacterType {
    
    let base: Character
    
    func getHealth() -> Int {
        return 50 + base.getHealth()
    }
     
    // New responsibility
    func battleCry() {
        print("RAWR")
    }
}

struct Epic: CharacterType {
    
    let base: Character
    
    func getHealth() -> Int {
        return 30 + base.getHealth()
    }
}

