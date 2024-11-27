//
//  ProfileViewDelegate.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation
import Repository


struct ProfileViewModel {
    let userName: String
    let email: String
    let imageName: String
}

protocol ProfileViewDelegate: AnyObject {
    func updateUI(_ viewModel: ProfileViewModel)
}

final class ProfileViewPresenterImpl  {
  
    //MARK: - Properties
    weak var view: ProfileViewDelegate?
    private let networking: NewsRepository
    private let router: AppRouter
  
    //MARK: - Init
    init(networking: NewsRepository,
         router: AppRouter) {
        self.networking = networking
        self.router = router
    }
}

//MARK: - ProfileViewPresenterImpl + ProfileViewPresenter
extension ProfileViewPresenterImpl: ProfileViewPresenter {
    func viewDidLoad() {
        view?.updateUI(
            .init(
                userName: showUserName(),
                email: showUserEmail(),
                imageName: showUserImage()
            )
        )
    }
    
    func show(_ credential: Credential) -> String {
        switch credential {
        case .name:
            return .init()
        case .email:
            return .init()
        case .image:
            return .init()
        }
    }
    
    func didTap(button interaction: Interaction) {
        
    }
    
    func viewDidLoad() {
        view?.updateUI(
            ProfileViewModel(
                userName: show(credentials: .name),
                email: show(credentials: .email),
                imageName: show(credentials: .image)
            )
        )
    }
    
    func show(credentials: Credentials) -> String {
        switch credentials {
        case .name:
            "Bob"
        case .email:
            "Bob@gmail.com"
        case .image:
            "profilePhoto"
        }
    }
    
    func didTap(button interaction: Interaction) {
        switch interaction {
        case .signOut:
            router.showOnboarding()
        case .changeLanguage:
            router.showLanguageView()
        case .conditions:
            router.showTermsView()
        case .chooseLanguage:
            router.popToRoot()
        case .backButton:
            router.back()
        }
    }
}

//MARK: - ViewModel 
struct ProfileViewModel {
    let userName: String
    let email: String
    let imageName: String
}

