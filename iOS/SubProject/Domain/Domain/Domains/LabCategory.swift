//
//  LabCategory.swift
//  Domain
//
//  Created by HS Lee on 2020/08/05.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation

public enum LabCategory: CustomStringConvertible {
    case swift
    case architecture(Architecture)
    case pattern(Pattern)
    case algorithm
    
    public var description: String {
        switch self {
        case .swift:
            return "Swift"
        case .architecture:
            return "Architecture"
        case .pattern:
            return "Pattern"
        case .algorithm:
            return "Algorithm"
        }
    }
}


public enum Architecture: String, CustomStringConvertible {
    case MVC
    case MVP
    case MVVM
    case MVVM_C
    case RIBs
    
    public var description: String {
        switch self {
        case .MVC:
            return "MVC is .."
        case .MVP:
            return "MVP is .."
        case .MVVM:
            return "MVVM is .."
        case .MVVM_C:
            return "MVVM_C is .."
        case .RIBs:
            return "RIBs is .."
        }
    }
}

public enum Pattern: String, CustomStringConvertible {
    case Proxy
    case Decorator
    
    public var description: String {
        switch self {
        case .Proxy:
            return "Proxy is .."
        case .Decorator:
            return "Decorator is .."
        }
    }
}

