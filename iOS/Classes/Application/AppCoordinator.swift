//
//  AppCoordinator.swift
//  iOS
//
//  Created by HS Lee on 2020/08/04.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit
import SwiftUI

import RxSwift
import Reusable

import MVC
import MVP

class AppCoordinator: BaseCoordinator<Void> {

    // MARK: - * Private --------------------
    private let window: UIWindow
    private let useStoryboardBase: Bool

    // MARK: - * Initialize --------------------
    init(window: UIWindow, useStoryboardBase: Bool) {
        self.window = window
        self.useStoryboardBase = useStoryboardBase
    }

    // MARK: - * Coordinate --------------------
    override func start() -> Observable<Void> {
        
        if useStoryboardBase {
            //window.rootViewController = ViewController.instantiate()
            //window.rootViewController = MVC.MVCViewController.instantiate()
            //window.rootViewController = MVP.MVPViewController.instantiate()
            let mainDependency = MainDependency(window: window)
            let mainCoordinator = MainCoordinator(dependency: mainDependency)
            return coordinate(to: mainCoordinator)            
        } else {
            // Create the SwiftUI view that provides the window contents.
            let contentView = ContentView()
            
            // Use a UIHostingController as window root view controller.
            window.rootViewController = UIHostingController(rootView: contentView)
        }
        window.makeKeyAndVisible()
//        let searchDependency = SearchDependency(window: window,
//                                                termProviding: RealmProvider(),
//                                                searchProviding: SearchProvider())
//        let serachCoordinator = SearchCoordinator(dependency: searchDependency)
//        return coordinate(to: serachCoordinator)
        return .never()
    }
}
