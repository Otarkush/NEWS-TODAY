//
//  ProfileViewImpl.swift
//  NEWS TODAY
//
//  Created by Илья Шаповалов on 23.10.2024.
//

import UIKit

final class ProfileViewImpl: UIView, ProfileView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setUpConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(_ viewModel: ProfilePageViewModel) {
        nameLabel.text = viewModel.name
        emailLabel.text = viewModel.email
        imageView.image = UIImage(systemName: viewModel.image)
        
        languageButton.addAction(
            UIAction { _ in viewModel.changeLanguage() },
            for: .touchUpInside
        )
        
        switch viewModel.logOut {
        case .inactive:
            logoutButton.removeAction(identifiedBy: logoutActionId, for: .touchUpInside)
            
        case .action(let action):
            logoutButton.addAction(
                UIAction(identifier: logoutActionId) { _ in action() },
                for: .touchUpInside
            )
        }
    }
    
    let logoutActionId = UIAction.Identifier("myLogoutAction")
    
    private func setupViews() {
        [imageView,
         nameLabel,
         emailLabel,
         languageButton,
         conditionsButton,
         logoutButton
        ].forEach(addSubview)
        
        backgroundColor = .white
    }
    
    private func setUpConstraints() {
       NSLayoutConstraint.activate([
           imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Drawing.imageTopPadding),
           imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Drawing.imageLeadingPadding),
           imageView.widthAnchor.constraint(equalToConstant: Drawing.imageSize),
           imageView.heightAnchor.constraint(equalToConstant: Drawing.imageSize),
           
           nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
           nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Drawing.nameLabelLeadingPadding),
           
           emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Drawing.emailLabelTopPadding),
           emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
           
           languageButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Drawing.languageButtonTopPadding),
           languageButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
           
           conditionsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Drawing.conditionsButtonTopPadding),
           conditionsButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
           
           logoutButton.topAnchor.constraint(equalTo: conditionsButton.bottomAnchor, constant: Drawing.signOutButtonTopPadding),
           logoutButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
       ])
   }
}

import SwiftUI

// MARK: - SwiftUI Preview for UIKit View
struct ProfileView_Preview: PreviewProvider {
    static var previews: some View {
        ProfileViewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct ProfileViewPageWrapper: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = ProfileViewImpl()
        view.render(
            .init(
                name: "Name",
                email: "Email",
                image: "person",
                changeLanguage: {},
                showConditions: {},
                logOut: .inactive
            )
        )
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
