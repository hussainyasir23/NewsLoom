//
//  AppCoordinator.swift
//  NewsLoom
//
//  Created by Yasir on 13/10/24.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            createNavigationController(
                for: makeHomeViewController(),
                title: "Home",
                image: UIImage(systemName: "house")
            ),
            createNavigationController(
                for: makeCategoriesViewController(),
                title: "Categories",
                image: UIImage(systemName: "list.bullet")
            ),
            createNavigationController(
                for: makeSearchViewController(),
                title: "Search",
                image: UIImage(systemName: "magnifyingglass")
            ),
            createNavigationController(
                for: makeSavedArticlesViewController(),
                title: "Saved",
                image: UIImage(systemName: "bookmark")
            ),
            createNavigationController(
                for: makeSettingsViewController(),
                title: "Settings",
                image: UIImage(systemName: "gear")
            )
        ]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func createNavigationController(for rootViewController: UIViewController,
                                            title: String,
                                            image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image ?? UIImage(systemName: "questionmark")
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navigationController
    }
    
    private func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewModel()
        return HomeViewController(viewModel: viewModel)
    }
    
    private func makeCategoriesViewController() -> UIViewController {
        let viewModel = CategoriesViewModel()
        return CategoriesViewController(viewModel: viewModel)
    }
    
    private func makeSearchViewController() -> UIViewController {
        return SearchViewController()
    }
    
    private func makeSavedArticlesViewController() -> UIViewController {
        return SavedArticlesViewController()
    }
    
    private func makeSettingsViewController() -> UIViewController {
        return SettingsViewController()
    }
}

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
    }
}

class SavedArticlesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Saved"
    }
}

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
    }
}
