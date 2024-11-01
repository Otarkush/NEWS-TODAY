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
        
        let navigationController = UINavigationController()
        let factory = AppFactoryImpl()
        let appRouter = AppRouterImpl(factory: factory, navigation: navigationController)

        let tabBarController = factory.makeTabBar(appRouter)
        navigationController.viewControllers = [tabBarController]

        window?.rootViewController = factory.makeScreen(.onboarding, appRouter)
        window?.makeKeyAndVisible()
    }
}

