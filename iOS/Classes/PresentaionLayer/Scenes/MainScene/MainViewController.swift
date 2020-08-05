//
//  MainViewController.swift
//  iOS
//
//  Created by HS Lee on 2020/08/04.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import Reusable

final class MainViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "MainScene", bundle: nil)
    
    // MARK: - * class func --------------------
    static func create() -> Self {
        Self.instantiate()
    }
    
    // MARK: - * type definition --------------------
    typealias ViewModelType = MainViewModel
    
    // MARK: - * dependencies --------------------
    var viewModel: ViewModelType!
    
    // MARK: - * properties --------------------
    private let disposeBag = DisposeBag()
    private let viewWillAppearRelay = PublishRelay<Void>()
    
    // MARK: - * IBOutlets --------------------
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - * Initialize --------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearRelay.accept(())
    }

    // MARK: - * setup --------------------
    private func setupAppearances() {
        title = "Table of Contents"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
    }
    
    private func setupTableView() {
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = Metric.tableRowHeight
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
    }

    private func prepareViewDidLoad() {
        setupAppearances()
        setupTableView()
        setupTableViewRx()
        bindViewModel()
    }

    // MARK: - * Binding --------------------
    private func setupTableViewRx() {
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(LabItem.self))
            .do(onNext: { [weak self] in
                self?.tableView.deselectRow(at: $0.0, animated: true)
            })
            .map { $0.1 }
            .map { MainCoordinator.Flow.labItem($0) }
            .bind(to: viewModel.flowRelay)
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = ViewModelType.Input(fetchLabItems: viewWillAppearRelay.asObservable())
        let output = viewModel.transform(input: input)
        output.fetchedLabItems
            .drive(tableView.rx.items) ({ (tv, row, item) -> UITableViewCell in
                let cell = tv.dequeueReusableCell(withIdentifier: "CellIdentifier", for: .init(item: row, section: 0)) as? SubtitleTableViewCell
                var title, detail: String?
                
                switch item.category {
                case let .architecture(subItem):
                    title = subItem.rawValue
                    detail = subItem.description
                case let .pattern(subItem):
                    title = subItem.rawValue
                    detail = subItem.description
                default:
                    break
                }
                cell?.textLabel?.text = title
                cell?.detailTextLabel?.text = detail
                return cell ?? .init()
            })
            .disposed(by: disposeBag)
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

// MARK: - * Metric --------------------
extension MainViewController {
    private struct Metric {
        static let tableRowHeight: CGFloat = 60
    }
}

