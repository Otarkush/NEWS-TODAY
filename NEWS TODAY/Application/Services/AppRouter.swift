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
    func showTermsView()
    func showLanguageView()
    func showOnboarding()
    func popToRoot()
    func back()
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
        let view = factory.makeScreen(.home, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showBookmarksView() {
        let view = factory.makeScreen(.bookmarks, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showCategoriesView() {
        let view = factory.makeScreen(.categories,self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showProfileView() {
        let view = factory.makeScreen(.profile,self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showDetailView() {
        let view = factory.makeScreen(.detail, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showTermsView() {
        let view = factory.makeScreen(.termsAndConditions, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showLanguageView() {
        let view = factory.makeScreen(.languageSelection,self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showOnboarding() {
        let view = factory.makeScreen(.onboarding, self)
        navigation.pushViewController(view, animated: true)
    }
    
    //MARK: - pop/back
    func back() {
        navigation.popViewController(animated: true)
    }

    func popToRoot() {
        navigation.popToRootViewController(animated: true)
    }
}
