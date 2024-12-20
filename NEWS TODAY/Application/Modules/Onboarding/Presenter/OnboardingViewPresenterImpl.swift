//
//  OnboardingPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation
import Repository


protocol OnboardingViewDelegate: AnyObject {
    func updateUI()
    func scrollToNextSlide()
}

final class OnboardingViewPresenterImpl {
    
    //MARK: - Properties
    weak var view: OnboardingViewDelegate?
    private let networking: NewsRepository
    private let router: AppRouter
    
    //MARK: - Init
    init(networking: NewsRepository, router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

//MARK: - OnboardingPresenterImpl + OnboardingViewPresenter
extension OnboardingViewPresenterImpl: OnboardingViewPresenter {
    func didTapStart() {
        router.showTabBar()
        UserDefaults.standard.set(true, forKey: "isFirstLaunchCompleted")
    }
    
    func didTapNext() {
        view?.scrollToNextSlide()
    }
    
}
