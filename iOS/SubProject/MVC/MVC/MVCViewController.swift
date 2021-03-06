//
//  MVCViewController.swift
//  mvc
//
//  Created by HS Lee on 2020/07/06.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit

import Domain
import CommonUI

import RxSwift
import RxCocoa
import Reusable

public class MVCViewController: UIViewController, StoryboardSceneBased {
    public static let sceneStoryboard = UIStoryboard(name: "MVC", bundle: Bundle.init(identifier: "io.hsleedevelop.iOS.MVC"))
    
    // MARK: - * Dependencies 💉 --------------------
    public var githubJobsUseCase: GithubJobsUseCase!
    
    // MARK: - * properties --------------------
    private let disposeBag = DisposeBag()

    // MARK: - * IBOutlets --------------------
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - * Initialize --------------------
    public override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewDidLoad()
    }

    private func prepareViewDidLoad() {
        setupAppearances()
        setupTableView()
        runUseCase()
    }
    
    // MARK: - * setup --------------------
    private func setupAppearances() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        tableView.register(.init(nibName: "GihtubJobTableViewCell", bundle: CommonUI.bundle), forCellReuseIdentifier: "GihtubJobTableViewCell")
    }
    
    // MARK: - * Binding --------------------
    private func setupTableViewRx() {
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(GithubJob.self))
            .do(onNext: { [weak self] in
                self?.tableView.deselectRow(at: $0.0, animated: true)
            })
            .map { $0.1 }
            .subscribe(onNext: { [weak self] job in
                self?.showWebView(with: job)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - * Main Logic --------------------
    private func runUseCase() {
        githubJobsUseCase.lists(page: 0)
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items) ({ (tv, row, job) -> UITableViewCell in
                let cell = tv.dequeueReusableCell(withIdentifier: "GihtubJobTableViewCell", for: .init(item: row, section: 0)) as? GihtubJobTableViewCell
                cell?.configure(job)
                return cell ?? .init()
            })
            .disposed(by: disposeBag)
    }
    
    private func showWebView(with job: GithubJob) {
        
    }

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
