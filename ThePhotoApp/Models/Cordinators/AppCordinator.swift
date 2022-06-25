//
//  AppCordinator.swift
//  ThePhotoApp
//
//  Created by Ален Авако on 23.06.2022.
//

import UIKit

final class AppCordinator: Cordinator {
    private var window: UIWindow?
    private let factory: FactoryProtocol
    private let tabBarController = UITabBarController()
    
    private enum TabBarSetUps {
        static let photos: String = "PHOTOS"
        static let photoIcon: String = "photo"
        static let favorite: String = "LIKED"
        static let favoriteIcon: String = "heart.fill"
    }
    
    init(window: UIWindow?, factory: FactoryProtocol) {
        self.window = window
        self.factory = factory
    }
    
    func start() {
        initWindow()
        initTabBar()
    }
    
    private func initWindow() {
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    private func initTabBar() {
        tabBarController.tabBar.tintColor = .black
        tabBarController.viewControllers = viewControllers()
    }
    
    private func viewControllers() -> [UIViewController] {
        let collectionViewModel = CollectionViewModel()
        let collectionVC = factory.getViewController(for: .photoCollection(viewModel: collectionViewModel))
        let collectionNC = createNavigationController(from: collectionVC, title: TabBarSetUps.photos, image: TabBarSetUps.photoIcon)
        
        let favoriteVC = factory.getViewController(for: .favoritePhotos)
        let favoriteNC = createNavigationController(from: favoriteVC, title: TabBarSetUps.favorite, image: TabBarSetUps.favoriteIcon)
        
        return [collectionNC, favoriteNC]
    }
    
    private func createNavigationController(from viewController: UIViewController, title: String, image: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(systemName: image)
        viewController.navigationItem.title = title
        return navigationController
    }
}
