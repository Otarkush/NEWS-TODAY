//
//  AppFactory.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

protocol MainFactory {
    
}

class MainRouter {
    let factory: MainFactory
    let parent: AppRouter
    let navigationController: UINavigationController
    
    init(
        factory: MainFactory,
        parent: AppRouter,
        navigationController: UINavigationController
    ) {
        self.factory = factory
        self.parent = parent
        self.navigationController = navigationController
    }
    
    
}

protocol AppFactory {
    func makeHomeModule(_ router: AppRouter) -> UIViewController
    func makeTabBar(_ router: AppRouter) -> UITabBarController
    func makeOnboardingModule(_ router: AppRouter) -> UIViewController
    func makeCategoriesModule(_ router: AppRouter) -> UIViewController
    func makeDetailModule(_ router: AppRouter) -> UIViewController
    func makeProfileModule(_ router: AppRouter) -> UIViewController
    func makeBookmarksModule(_ router: AppRouter) -> UIViewController
    func makeTermsAndConditionsScreen(_ router: AppRouter) -> UIViewController
}

final class AppFactoryImpl  {
    
    //MARK: - Properties
    private let networking: AppNetworking
    
    //MARK: - Init
    init() {
        self.networking = NetworkingManagerImpl()
    }
    
    //MARK: - Methods
    func makeAppRouter(_ navigationController: UINavigationController) -> AppRouter {
        AppRouterImpl(factory: self,navigation: navigationController)
    }
}

//MARK: - AppFactoryImpl + AppFactory
extension AppFactoryImpl: AppFactory {
    
    //MARK: - Create TabBar
    func makeTabBar(_ router: AppRouter) -> UITabBarController {
        let tabBarController = MainTabBarController()
        
        let homeModule = makeHomeModule(router)
        let categoriesModule = makeCategoriesModule(router)
        let bookmarksModule = makeBookmarksModule(router)
        let profileModule = makeProfileModule(router)
        
        let homeNavController = UINavigationController(rootViewController: homeModule)
        tabBarController.viewControllers = [
            homeNavController,
            categoriesModule,
            bookmarksModule ,
            profileModule
        ]
        return tabBarController
    }
    
    //MARK: - Create Modules
    func makeHomeModule(_ router: AppRouter) -> UIViewController {
        
        let presenter = HomeViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = HomeViewController(presenter: presenter)
        presenter.view = viewController
        viewController.tabBarItem = makeTabItem(.home)
        
        return viewController
    }
    
    enum TabType: String {
        case home
        case categories
        case bookmarks
        case profile
        
        var title: String { rawValue.uppercased() }
        
        var imageNormal: UIImage? {
            switch self {
            case .home: UIImage(systemName: "house")
            case .categories: UIImage(systemName: "square.grid.2x2")
            case .bookmarks: UIImage(systemName: "bookmark")
            case .profile: UIImage(systemName: "person")
            }
        }
        
        var imageSelected: UIImage? {
            switch self {
            case .home: UIImage(systemName: "house.fill")
            case .categories: UIImage(systemName: "square.grid.2x2.fill")
            case .bookmarks: UIImage(systemName: "bookmark.fill")
            case .profile: UIImage(systemName: "person.fill")
            }
        }
    }
    
    func makeTabItem(_ type: TabType) -> UITabBarItem {
        UITabBarItem(title: type.title, image: type.imageNormal, selectedImage: type.imageSelected)
    }
    
    func makeCategoriesModule(_ router: AppRouter) -> UIViewController {
        let presenter = CategoriesViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = CategoriesViewController(presenter: presenter)
        presenter.view = viewController
        
        viewController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "square.grid.2x2"),
            selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        
        return viewController
    }
    
    func makeBookmarksModule(_ router: AppRouter) -> UIViewController {
        let presenter = BookmarksViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = BookmarksViewController(presenter: presenter)
        presenter.view = viewController
        
        viewController.tabBarItem = UITabBarItem(
            title: "Bookmarks",
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill"))
        
        return viewController
    }
    
    func makeProfileModule(_ router: AppRouter) -> UIViewController {
        let presenter = ProfileViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = ProfileViewController(
            presenter: presenter,
            profileView: ProfileViewImpl()
        )
        presenter.view = viewController
        
        viewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
        
        return viewController
    }
    
    func makeOnboardingModule(_ router: AppRouter) -> UIViewController {
        
        let presenter = OnboardingViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = OnboardingViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
    
    func makeDetailModule(_ router: AppRouter) -> UIViewController {
        let presenter = DetailViewPresenterImpl(
            networking: networking,
            router: router)
        
        let viewController = DetailViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
    
    //MARK: - Create screens
   func makeTermsAndConditionsScreen(_ router: AppRouter) -> UIViewController {
        let viewController = TermsViewController(
            router: router)
        return viewController
    }
}
