//
//  MainRouter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

protocol AppRouter: AnyObject {
    func showHomeView()
}

final class AppRouterImpl: AppRouter {
    
    //MARK: - Properties
    private let factory: AppFactory
    private let navigation: UINavigationController
    
    //MARK: - Init
    init(factory: AppFactory, navigation: UINavigationController) {
        self.factory = factory
        self.navigation = navigation
    }
    
    func showHomeView() {
        let view = factory.makeHomeModule(self)
        navigation.pushViewController(view, animated: true)
    }
}
