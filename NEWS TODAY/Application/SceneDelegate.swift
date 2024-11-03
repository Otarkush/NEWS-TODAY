//
//  SceneDelegate.swift
//  NEWS TODAY
//
//  Created by Andrew Linkov on 20.10.2024.
//

import UIKit
import Repository

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
//        Task { await NewsRepository.shared.register() }

        let navigationController = UINavigationController()
        let factory = AppFactoryImpl()
        let appRouter = AppRouterImpl(factory: factory, navigation: navigationController, window: window)
        appRouter.start()
    }
}
