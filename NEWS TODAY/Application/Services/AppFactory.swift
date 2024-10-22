//
//  AppFactory.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

protocol AppFactory {
    func makeHomeModule(_ router: AppRouter) -> UIViewController
    func makeTabBar(_ viewControllers: UIViewController...) -> UITabBarController
}

final class AppFactoryImpl: AppFactory  {
    
    //MARK: - Properties
    private let networking: AppNetworking
    
    //MARK: - Init
    init() {
        self.networking = NetworkingManagerImpl()
    }
    
    //MARK: - Methods
    static func makeAppRouter(_ navigationController: UINavigationController) -> AppRouter {
        
        AppRouterImpl(
            factory: AppFactoryImpl(),
            navigation: navigationController)
    }
    
    //MARK: - Methods
    func makeHomeModule(_ router: AppRouter) -> UIViewController {
        
        let presenter = HomeViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = HomeViewController(presenter: presenter)
        presenter.view = viewController
    #warning("Норм что в здесь создаем табБар итемы?")
        viewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))
        
        return viewController
    }
    
    func makeTabBar(_ viewControllers: UIViewController..., factory: AppFactory) -> UITabBarController {
        let tabBar = MainTabBarController()
        tabBar.viewControllers = viewControllers
        return tabBar
    }
}
