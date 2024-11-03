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
    func showDetailView(for articles: [Article], selectedIndex: Int)
    func showTermsView()
    func showLanguageView()
    func showOnboarding()
    func showTabBar()
    func start()
    func popToRoot()
    func back()
}

final class AppRouterImpl: AppRouter {
    
    // MARK: - Properties
    private let factory: AppFactory
    private let navigation: UINavigationController
    private let window: UIWindow?
    
    // MARK: - Init
    init(factory: AppFactory, navigation: UINavigationController, window: UIWindow? = nil) {
        self.factory = factory
        self.navigation = navigation
        self.window = window
    }
    
    // MARK: - Start Method
    func start() {
        let isLaunchedBefore = UserDefaults.standard.bool(forKey: "isLaunchedBefore")
        
        if isLaunchedBefore {
            showTabBar()
        } else {
            showOnboarding()
        }
        
        window?.rootViewController = navigation
        window?.backgroundColor = .clear
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Navigation Methods
    func showHomeView() {
        let view = factory.makeScreen(.home, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showBookmarksView() {
        let view = factory.makeScreen(.bookmarks, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showCategoriesView() {
        let view = factory.makeScreen(.categories, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showProfileView() {
        let view = factory.makeScreen(.profile, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showDetailView(for articles: [Article], selectedIndex: Int) {
        let view = factory.makeScreen(.detail, self, articles: articles, selectedIndex: selectedIndex)
        navigation.pushViewController(view, animated: true)
    }
    
    func showTermsView() {
        let view = factory.makeScreen(.termsAndConditions, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showLanguageView() {
        let view = factory.makeScreen(.languageSelection, self)
        navigation.pushViewController(view, animated: true)
    }
    
    func showOnboarding() {
        let onboardingViewController = factory.makeScreen(.onboarding, self)
        navigation.isNavigationBarHidden = true
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigation.navigationBar.shadowImage = UIImage()
        navigation.navigationBar.isTranslucent = true
        navigation.view.backgroundColor = .clear
        navigation.setViewControllers([onboardingViewController], animated: false)
    }
    
    func showTabBar() {
        let tabBarController = factory.makeTabBar(self)
        navigation.isNavigationBarHidden = true
        navigation.setViewControllers([tabBarController], animated: true)
        
    }
    
    // MARK: - Back Navigation
    func back() {
        navigation.popViewController(animated: true)
    }

    func popToRoot() {
        navigation.popToRootViewController(animated: true)
    }
}
