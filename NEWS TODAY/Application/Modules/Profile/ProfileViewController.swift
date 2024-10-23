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

private enum Drawing {
    static let imageSize: CGFloat = 72
    static let imageTopPadding: CGFloat = 16
    static let imageLeadingPadding: CGFloat = 16
    static let nameLabelLeadingPadding: CGFloat = 24
    static let emailLabelTopPadding: CGFloat = 8
}

final class ProfileViewController: UIViewController {
  
    //MARK: - Properties
    private let presenter: ProfileViewPresenter

    private var name: String = .init()
    private var email: String = .init()
    private var profileImage: String = .init()
    
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
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Private Methods
    private func setupViews() {
        [imageView, nameLabel, emailLabel ].forEach { view.addSubview($0)}
        updateUI()
    }
}

//MARK: - ProfileViewController + Constraints
private extension ProfileViewController {
    
     func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Drawing.imageTopPadding),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Drawing.imageLeadingPadding),
            imageView.widthAnchor.constraint(equalToConstant: Drawing.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: Drawing.imageSize),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Drawing.nameLabelLeadingPadding),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Drawing.emailLabelTopPadding),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
        ])
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
