//
//  ProfileViewDelegate.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation

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
    private let networking: AppNetworking
    private let router: AppRouter
  
    //MARK: - Init
    init(networking: AppNetworking,
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
    
    func didTapConditions() {
        router.showTermsView()
    }
    
    func didTapChangeLanguage() {
        print("didTapChangeLanguage")
    }
    
    func didTapSignOut() {
        print("didTapSignOut")
    }

    func showUserName() -> String {
        "Bob"
    }
    
    func showUserEmail() -> String {
       "Bob1@gmail.com"
    }
    
    func showUserImage() -> String {
        "profilePhoto"
    }
}
