//
//  CommonUI.swift
//  CommonUI
//
//  Created by HS Lee on 2020/08/06.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation

public class CommonUI {
    public static var bundle: Bundle? = {
        let identifier = Bundle.main.bundleIdentifier.map { $0 + ".CommonUI" }
        return Bundle(identifier: identifier ?? "")
    }()
}

