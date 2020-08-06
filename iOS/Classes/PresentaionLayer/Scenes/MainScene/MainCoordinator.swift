//
//  MainCoordinator.swift
//  iOS
//
//  Created by HS Lee on 2020/08/04.
//  Copyright © 2020 HS Lee. All rights reserved.
//

import UIKit
import Domain
import Data

import MVC
import MVP

import NetworkProvider

import RxSwift
import RxCocoa
import RxSwiftExt


public protocol Dependency: class {}

protocol MainDependencyProtocol: Dependency {
    var window: UIWindow { get set }
}

final class MainDependency: MainDependencyProtocol {
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

final class MainCoordinator: BaseCoordinator<Void> {
    // MARK: - * Type Defines --------------------
    enum Flow {
        case labItem(LabItem)
    }
    
    // MARK: - * Properties --------------------
    //private let window: UIWindow
    private var viewController: MainViewController!

    //private var appListCoordinatorDisposable: Disposable?
    
    private let dependency: MainDependencyProtocol
    
    // MARK: - * Initialize --------------------
    init(dependency: MainDependencyProtocol) {
        self.dependency = dependency
    }
    
    // MARK: - * Coordinante --------------------
    override func start() -> Observable<Void> {
        self.viewController = MainViewController.create()
        
        let labItemsRepository = LabItemsRepositoryImpl()
        let viewModel = MainViewModel(labItemListUseCase: LabItemListUseCaseImpl(labItemsRepository: labItemsRepository))
        viewController.viewModel = viewModel
        bindFlow(viewModel: viewModel)

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = .init(tabBarSystemItem: .search, tag: 0)
        
//        let tabBarController = UITabBarController()
//        tabBarController.setViewControllers([navigationController], animated: false)
        dependency.window.rootViewController = navigationController
        dependency.window.makeKeyAndVisible()

        return Observable.never()
    }
    
    private func bindFlow(viewModel: MainViewModel) {
        viewModel.flowRelay
            .subscribe(onNext: { [weak self] flow in
                switch flow {
                case let .labItem(item):
                    self?.play(with: item)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func play(with item: LabItem) {
        switch item.category {
        case let .architecture(subItem):
            self.showArchitecture(with: subItem)
            break
        case let .pattern(subItem): //webview.
            break
        default:
            break
        }
    }
    
    private func showArchitecture(with subItem: Architecture) {
        switch subItem {
        case .MVC:
            let child = MVC.MVCViewController.instantiate()
            
            let networkProvider = NetworkProvider(baseURL: AppConfiguration.shared.apiBaseURL)
            let githubJobsRepositoryImpl = GithubJobsRepositoryImpl(service: networkProvider)
            child.githubJobsUseCase = GithubJobsUseCaseImpl(githubJobsRepository: githubJobsRepositoryImpl)
            
            viewController.present(child, animated: true, completion: nil)
        case .MVP:
            let child = MVP.MVPViewController.instantiate()
            
            let networkProvider = NetworkProvider(baseURL: AppConfiguration.shared.apiBaseURL)
            let githubJobsRepositoryImpl = GithubJobsRepositoryImpl(service: networkProvider)
            child.githubJobsUseCase = GithubJobsUseCaseImpl(githubJobsRepository: githubJobsRepositoryImpl)
            
            viewController.present(child, animated: true, completion: nil)
        default:
            break
        }
    }
    
//    private func coordianteCancelSearch() {
//        var vc = viewController.resultViewController.children.first
//        vc?.view.removeFromSuperview()
//        vc?.removeFromParent()
//        vc = nil
//
//        appListCoordinatorDisposable?.dispose()
//    }
//
//    private func coordinateSearch(with term: String) {
//        let appListDependency = AppListDependency(viewController: viewController.resultViewController,
//                                                  searchProviding: SearchProvider(),
//                                                  term: term)
//        let coordinator = AppListCoordinator(dependency: appListDependency)
//        appListCoordinatorDisposable = coordinate(to: coordinator)
//            .subscribe()
//    }
//
//    private func coordianteMatching(with term: String) {
//        if termRelay.value != term {
//            coordianteCancelSearch()
//        }
//        termRelay.accept(term)
//    }
//
//    private func setupMatchTermCoodinator() {
//        let matchesDependency = MatchesDependency(termProviding: self.dependency.termProviding,
//                                                  termObs: termRelay.asObservable())
//        let coordinator = MatchesCoordinator(dependency: matchesDependency)
//        viewController.resultViewController = coordinator.viewController
//
//        coordinate(to: coordinator)
//            .subscribe(onNext: { [weak self] result in
//                switch result {
//                case .search(let term):
//                    self?.viewController.viewModel.flowRelay.accept(.cancelSearch)
//                    self?.coordinateSearch(with: term)
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//
    deinit {
        //appListCoordinatorDisposable?.dispose()
        logD("\(NSStringFromClass(type(of: self))) deinit")
    }
}
