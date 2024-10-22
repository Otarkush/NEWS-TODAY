//
//  OnboardingViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit

protocol OnboardingViewPresenter: AnyObject {}

final class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    private let presenter: OnboardingViewPresenter?
    
    //MARK: - Init
    
    init(presenter: OnboardingViewPresenter?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
}

//MARK: - OnboardingViewController + OnboardingViewDelegate
extension OnboardingViewController: OnboardingViewDelegate {}
