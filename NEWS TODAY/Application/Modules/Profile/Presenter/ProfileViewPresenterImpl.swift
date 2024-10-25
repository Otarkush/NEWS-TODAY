//
//  ProfileViewDelegate.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import Foundation

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
            router.showTermsView()
        case .changeLanguage:
            router.showTermsView()
        case .conditions:
            router.showTermsView()
        }
    }
}

//MARK: - ViewModel experiment
struct ProfileViewModel {
    let userName: String
    let email: String
    let imageName: String
}

