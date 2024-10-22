//
//  MainRouter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

protocol AppRouter: AnyObject {
    func showHomeView()
    func showBookmarksView()
    func showCategoriesView()
    func showProfileView()
    func showDetailView()
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
    
    func showBookmarksView() {
        let view = factory.makeBookmarksModule(self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showCategoriesView() {
        let view = factory.makeCategoriesModule(self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showProfileView() {
        let view = factory.makeProfileModule(self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showDetailView() {
        let view = factory.makeDetailModule(self)
        navigation.pushViewController(view, animated: true)
    }
}
