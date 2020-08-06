//
//  MVPViewController.swift
//  MVP
//
//  Created by HS Lee on 2020/08/04.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit

import Domain
import CommonUI

import RxSwift
import RxCocoa
import Reusable

public class MVPViewController: UIViewController, StoryboardSceneBased {
    // MARK: - * Static func --------------------
    public static let sceneStoryboard = UIStoryboard(name: "MVP", bundle: Bundle.init(identifier: "io.hsleedevelop.iOS.MVP"))

    // MARK: - * Dependencies --------------------
    public var githubJobsUseCase: GithubJobsUseCase!
    
    // MARK: - * properties --------------------
    private var mvpPresenter: MVPPresenter?
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
        //Instance member 'bundle' cannot be used on type 'CommonUI'; did you mean to use a value of this type instead?
        tableView.register(.init(nibName: "GihtubJobTableViewCell", bundle: CommonUI.bundle), forCellReuseIdentifier: "GihtubJobTableViewCell")
    }

    // MARK: - * Main Logic --------------------
    private func runUseCase() {
        mvpPresenter = .init(githubJobsUseCase: githubJobsUseCase, view: self)
        mvpPresenter?.fetchGithubJobs(page: 1)
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


extension MVPViewController: MVPPresenterView {
    
    func updateFetchedGithubJobs(jobsObs: Observable<[GithubJob]>) {
        jobsObs
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items) ({ (tv, row, job) -> UITableViewCell in
                let cell = tv.dequeueReusableCell(withIdentifier: "GihtubJobTableViewCell", for: .init(item: row, section: 0)) as? GihtubJobTableViewCell
                cell?.configure(job)
                return cell ?? .init()
            })
            .disposed(by: disposeBag)
    }
}
