//
//  OnboardingPresenterImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation

protocol OnboardingViewDelegate: AnyObject {}

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
extension OnboardingViewPresenterImpl: OnboardingViewPresenter {}
