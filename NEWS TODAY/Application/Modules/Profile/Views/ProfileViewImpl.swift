//
//  ProfileViewImpl.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 24.10.2024.
//
import UIKit
import SwiftUI

final class ProfileViewImpl: UIView, ProfileView {
    
    // MARK: - UI Elements
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
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
    
    lazy var languageButton = ProfileButton(type: .changeLanguage)
    lazy var conditionsButton = ProfileButton(type: .conditions)
    lazy var logoutButton = ProfileButton(type: .signOut)

    
    // MARK: - Button Actions
//    @objc private func languageButtonTapped() {
//        presenter.didTap(button: .changeLanguage)
//    }
//
//    @objc private func conditionsButtonTapped() {
//        presenter.didTap(button: .conditions)
//    }
//
//    @objc private func logoutButtonTapped() {
//        presenter.didTap(button: .signOut)
//    }
    
    
    //MARK: - Setup Constraints
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
}
