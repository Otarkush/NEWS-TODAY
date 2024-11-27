//
//  ProfileViewPresenter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI

enum Credential { case name, email, image }
enum Interaction { case conditions, signOut, lang }

protocol ProfileViewPresenter: AnyObject {
    func show(_ credential: Credential) -> String
    func viewDidLoad()
    func didTap(button interaction: Interaction)
}

typealias Action = () -> Void

struct ProfilePageViewModel {
    let name: String
    let email: String
    let image: String

    let changeLanguage: Action
    let showConditions: Action
    let logOut: ButtonState
    
    enum ButtonState {
        case inactive
        case action(Action)
    }
}

protocol ProfileView: UIView {
    func render(_ viewModel: ProfilePageViewModel)
}

final class ProfileViewController: UIViewController {
    //MARK: - Properties
    private let presenter: ProfileViewPresenter
    private let profileView: ProfileView

    //MARK: - Init
    init(
        presenter: ProfileViewPresenter,
        profileView: ProfileView
    ) {
        self.presenter = presenter
        self.profileView = profileView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - Button Actions
    @objc private func languageButtonTapped() {
        presenter.didTap(button: .lang)
    }

    @objc private func conditionsButtonTapped() {
        presenter.didTap(button: .conditions)
    }

    @objc private func logoutButtonTapped() {
        presenter.didTap(button: .lang)
    }
}

//MARK: - ProfileViewController + ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func updateUI(_ viewModel: ProfileViewModel) {
//        profileView.nameLabel.text = viewModel.userName
//        profileView.emailLabel.text = viewModel.email
//        profileView.imageView.image = UIImage(named: viewModel.imageName)
        profileView.render(
            .init(
                name: viewModel.userName,
                email: viewModel.email,
                image: viewModel.imageName,
                changeLanguage: { self.languageButtonTapped() },
                showConditions: { self.conditionsButtonTapped() },
                logOut: .inactive
            )
        )
    }
}

// MARK: - SwiftUI Preview for UIKit View
struct ProfileViewController_Preview: PreviewProvider {
    static var previews: some View {
        ProfileViewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct ProfileViewWrapper: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let profileViewController = ProfileViewController(
            presenter: ProfileViewPresenterImpl(
                networking: NetworkingManagerImpl(),
                router: AppRouterImpl(
                    factory: AppFactoryImpl(),
                    navigation: UINavigationController())),
            profileView: ProfileViewImpl()
        )
        
        return profileViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
