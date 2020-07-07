//
//  ViewController.swift
//  iOS
//
//  Created by HS Lee on 2020/07/06.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import Foundation
import UIKit
import Reusable

class ViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)

    // MARK: - * properties --------------------


    // MARK: - * IBOutlets --------------------


    // MARK: - * Initialize --------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAppearance()
        self.prepareViewDidLoad()
    }


    private func setupAppearance() {
        self.view.backgroundColor = .white
    }

    func prepareViewDidLoad() {

    }

    // MARK: - * Main Logic --------------------


    // MARK: - * UI Events --------------------


    // MARK: - * Memory Manage --------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController {

}
