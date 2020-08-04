//
//  MVPViewController.swift
//  MVP
//
//  Created by HS Lee on 2020/08/04.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import UIKit
import Reusable
//import Domain
import Patterns

public class MVPViewController: UIViewController, StoryboardSceneBased {
    public static let sceneStoryboard = UIStoryboard(name: "MVP", bundle: Bundle.init(identifier: "io.hsleedevelop.iOS.MVP"))
    // MARK: - * properties --------------------


    // MARK: - * IBOutlets --------------------


    // MARK: - * Initialize --------------------

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAppearances()
        self.setupUI()
        self.prepareViewDidLoad()
    }


    private func setupAppearances() {
        self.view.backgroundColor = .white
    }


    private func setupUI() {

    }


    func prepareViewDidLoad() {

    }

    // MARK: - * Main Logic --------------------


    // MARK: - * UI Events --------------------


    // MARK: - * Memory Manage --------------------

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        #if DEBUG
        print("\(NSStringFromClass(type(of: self))) deinit")
        #endif
    }
}


extension MVPViewController {

}
