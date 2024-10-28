//
//  MainTabBarController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    // MARK: Private methods
    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        tabBar.tintColor = .purplePrimary
        tabBar.unselectedItemTintColor = .greyLight
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance

        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.cornerRadius = 12
        tabBar.layer.borderColor = UIColor.greyLight.cgColor
        tabBar.layer.borderWidth = 0.5
        tabBar.clipsToBounds = true
    }
}
