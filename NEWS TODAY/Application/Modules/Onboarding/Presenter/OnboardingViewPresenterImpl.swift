//
//  OnboardingPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation

protocol OnboardingViewDelegate: AnyObject {
    func updateUI()
}

final class OnboardingViewPresenterImpl {
    
    //MARK: - Properties
    weak var view: OnboardingViewDelegate?
    private let networking: AppNetworking
    private let router: AppRouter
    
    //MARK: - Init
    init(networking: AppNetworking, router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

//MARK: - OnboardingPresenterImpl + OnboardingViewPresenter
extension OnboardingViewPresenterImpl: OnboardingViewPresenter {
    func setUpSlidesScrollView(slides: [any OnboardingView]) {
        
    }
    
#warning("Может лучше на вью этот метод отдать?")
    func createSlides() -> [OnboardingView] {
        let firstOnboardingView = OnboardingViewImpl()
        let secondOnboardingView = OnboardingViewImpl()
        secondOnboardingView.configureView(
            firstText: nil,
            descriptionText: "Save articles to your library",
            nextText: "Next",
            image: "onb2"
        )
        let thirdOnboardingView = OnboardingViewImpl()
        thirdOnboardingView.configureView(
            firstText: nil,
            descriptionText: "Select your favorite topics",
            nextText: "Get Started",
            image: "onb3"
        )
        
        return [firstOnboardingView, secondOnboardingView, thirdOnboardingView]
    }
    
    
//    func setUpSlidesScrollView(slides: [OnboardingView]) {
//        view.onboardingView.scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
//    }

    
    func setupUI() {
    }
}
