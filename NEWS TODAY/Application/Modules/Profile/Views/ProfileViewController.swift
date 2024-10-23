//
//  ProfileViewPresenter.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 22.10.2024.
//

import UIKit
import SwiftUI

protocol ProfileViewPresenter: AnyObject {
    func showUserName() -> String
    func showUserEmail() -> String
    func showUserImage() -> String
}

final class ProfileViewController: UIViewController {
    
    //MARK: - Drawing
    private enum Drawing {
        static let imageSize: CGFloat = 72
        static let imageTopPadding: CGFloat = 16
        static let imageLeadingPadding: CGFloat = 16
        static let nameLabelLeadingPadding: CGFloat = 24
        static let emailLabelTopPadding: CGFloat = 8
        static let languageButtonTopPadding: CGFloat = 50
        static let conditionsButtonTopPadding: CGFloat = -120
        static let signOutButtonTopPadding: CGFloat = 30
    }
    
    //MARK: - Properties
    private let presenter: ProfileViewPresenter

    //MARK: - Init
    init(presenter: ProfileViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI Elements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let languageButton = ProfileButton(type: .changeLanguage)
    private let conditionsButton = ProfileButton(type: .conditions)
    private let logoutButton = ProfileButton(type: .signOut)
   
    // MARK: - Private Methods
    private func setupViews() {
        [imageView,
         nameLabel,
         emailLabel,
         languageButton,
         conditionsButton,
         logoutButton
        ].forEach { view.addSubview($0)}
        
        view.backgroundColor = .white
        updateUI()
    }
}

//MARK: - ProfileViewController + ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func updateUI() {
        nameLabel.text = presenter.showUserName()
        emailLabel.text = presenter.showUserEmail()
        imageView.image = UIImage(named: presenter.showUserImage())
    }
}

//MARK: - ProfileViewController + Constraints
private extension ProfileViewController {
    
     func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Drawing.imageTopPadding),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Drawing.imageLeadingPadding),
            imageView.widthAnchor.constraint(equalToConstant: Drawing.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: Drawing.imageSize),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Drawing.nameLabelLeadingPadding),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Drawing.emailLabelTopPadding),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            languageButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Drawing.languageButtonTopPadding),
            languageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            conditionsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Drawing.conditionsButtonTopPadding),
            conditionsButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: conditionsButton.bottomAnchor, constant: Drawing.signOutButtonTopPadding),
            logoutButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
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
                    navigation: UINavigationController())))
        
        return profileViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
