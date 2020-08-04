//
//  MVCViewController.swift
//  mvc
//
//  Created by HS Lee on 2020/07/06.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import UIKit
import Reusable
//import Domain
import Patterns

public class MVCViewController: UIViewController, StoryboardSceneBased {
    public static let sceneStoryboard = UIStoryboard(name: "MVC", bundle: Bundle.init(identifier: "io.hsleedevelop.iOS.MVC"))
    
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
        let pp = Patterns()
        print(pp)
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


extension MVCViewController {

}
