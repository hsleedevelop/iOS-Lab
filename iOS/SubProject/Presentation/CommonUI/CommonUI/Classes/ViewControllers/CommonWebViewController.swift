//
//  CommonWebViewController.swift
//  CommonUI
//
//  Created by HS Lee on 2020/08/06.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit
import WebKit

class CommonWebViewController: UIViewController {

    // MARK: - * properties --------------------


    // MARK: - * IBOutlets --------------------
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - * LifeCycles --------------------

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareViewDidLoad()
    }

    // MARK: - * prepare --------------------
    func prepareViewDidLoad() {
        setupAppearances()
        setupUI()
    }

    // MARK: - * Setup --------------------
    private func setupAppearances() {

    }

    private func setupUI() {

    }

    // MARK: - * Binding --------------------
    private func bindViewModel() {
        
    }
    
    // MARK: - * Main Logic --------------------


    // MARK: - * UI Events --------------------


    // MARK: - * Memory Manage --------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        #if DEBUG
        print("\(NSStringFromClass(type(of: self))) deinit")
        #endif
    }
}


extension CommonWebViewController {

}
