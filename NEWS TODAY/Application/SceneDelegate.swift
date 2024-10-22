//
//  SceneDelegate.swift
//  NEWS TODAY
//
//  Created by Andrew Linkov on 20.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let factory = AppFactoryImpl()
        let rootRouter = factory.makeHomeModule(
            AppRouterImpl(
                factory: factory,
                navigation: UINavigationController()))
             
             // Создаем TabBarController
        let tabBarController = factory.makeTabBar facotry: factory)
             
             window.rootViewController = tabBarController
             self.window = window
             window.makeKeyAndVisible()
         }
    }

}

