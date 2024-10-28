//
//  ProfileViewPresenter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI

//MARK: - Protocols
protocol ProfileView: UIView {
    var nameLabel: UILabel { get }
    var emailLabel: UILabel { get }
    var imageView: UIImageView { get }
    
    var languageButton: ProfileButton { get  }
    var conditionsButton: ProfileButton { get  }
    var logoutButton: ProfileButton { get  }
}

enum Credentials { case  name, email, image }
enum Interaction { case signOut, changeLanguage, conditions, chooseLanguage, backButton}

protocol ProfileViewPresenter: AnyObject {
    func show(credentials: Credentials) -> String
    func didTap(button interaction: Interaction)
    func viewDidLoad()
}

//MARK: - ProfileViewController
final class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    private let presenter: ProfileViewPresenter
    private let profileView: ProfileView

    //MARK: - Init
    init(
        presenter: ProfileViewPresenter,
        profileView: ProfileView
    ) {
        self.profileView = profileView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        presenter.viewDidLoad()
    }
    
    override func loadView() {
        view = profileView
        setupButtonActions()
    }
    
    // MARK: - Button Actions
    private func setupButtonActions() {
        profileView.languageButton.addAction(
            UIAction { [weak self] _ in
                self?.languageButtonTapped()
            },
            for: .touchUpInside
        )
        
        profileView.conditionsButton.addAction(
            UIAction { [weak self] _ in
                self?.conditionsButtonTapped()
            },
            for: .touchUpInside
        )
        
        profileView.logoutButton.addAction(
            UIAction { [weak self] _ in
                self?.logoutButtonTapped()
            },
            for: .touchUpInside
        )
    }
    
    private func languageButtonTapped() {
        presenter.didTap(button: .changeLanguage)
    }

    private func conditionsButtonTapped() {
        presenter.didTap(button: .conditions)
    }

    private func logoutButtonTapped() {
        presenter.didTap(button: .signOut)
    }
}

//MARK: - ProfileViewController + ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    
    func updateUI(_ viewModel: ProfileViewModel) {
        profileView.nameLabel.text = viewModel.userName
        profileView.emailLabel.text = viewModel.email
        profileView.imageView.image = UIImage(named: viewModel.imageName)
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
            profileView: ProfileViewImpl())
        
        return profileViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
