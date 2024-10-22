//
//  MainTabBarController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

//final class MainTabBarController: UITabBarController {
//    
//}

import UIKit

final class MainTabBarController: UITabBarController {
    
    let factory: AppFactory
    
    init(factory: AppFactory) {
        self.factory = factory
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let secondModule = UIViewController() // Второй модуль для примера
        secondModule.view.backgroundColor = .blue
        
        let homeModule = factory.makeHomeModule(AppRouterImpl(factory: factory, navigation: UINavigationController()))
        
        homeModule.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))
        
        let viewControllers = [homeModule, secondModule].map { UINavigationController(rootViewController: $0) }
        self.viewControllers = viewControllers
    }
}
