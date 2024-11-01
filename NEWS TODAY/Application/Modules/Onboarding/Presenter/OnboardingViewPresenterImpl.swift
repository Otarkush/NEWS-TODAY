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
    func setUpSlidesScrollView(slides: [OnboardingView]) {
        
    }

    
    
//    func setUpSlidesScrollView(slides: [OnboardingView]) {
//        view.onboardingView.scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
//    }

    
    func setupUI() {
    }
}
