//
//  TermsViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 23.10.2024.
//

import UIKit
import SwiftUI

final class TermsViewController: UIViewController {

    //MARK: - Properties
    private let router: AppRouter
    
    //MARK: - Init
    init(router: AppRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = Drawing.termsText
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Drawing.fontSize)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.backButton, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - UI Setup
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentLabel)
        view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Drawing.scrollViewSidePadding),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Drawing.scrollViewSidePadding),
            
            contentLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Drawing.backButtonTopPadding),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Drawing.backButtonSidePadding),
            backButton.heightAnchor.constraint(equalToConstant: Drawing.backButtonSize),
            backButton.widthAnchor.constraint(equalToConstant: Drawing.backButtonSize)
        ])
    }
    
    //MARK: - Actions
    
    @objc private func backButtonTapped() {
        router.back()
    }
}

// MARK: - Constants
private enum Drawing {
    static let fontSize: CGFloat = 16.0
    static let scrollViewSidePadding: CGFloat = 16.0
    static let backButtonTopPadding: CGFloat = 16.0
    static let backButtonSidePadding: CGFloat = 16.0
    static let backButtonSize: CGFloat = 44.0
    
    static let termsText = """
    Terms and Conditions:

    By using the NEWS TODAY app, you agree to the following terms and conditions:
    
    1. The app provides news content from various sources.
    2. You agree to use the app for personal and non-commercial purposes only.
    3. The app collects certain usage data for analytical purposes.
    4. We are not responsible for the accuracy of the news content provided by third-party sources.
    5. By continuing to use this app, you agree to periodically check for updates to the terms.
    6. The use of our service is governed by the laws of your country.
    7. If any part of these terms is deemed invalid or unenforceable, the remaining parts remain in effect.
    8. We reserve the right to modify or discontinue the app without notice at any time.

    For more details, please contact our support team.

    Further Terms and Conditions:
    
    - The app offers various news sections that you can subscribe to.
    - Content availability may differ depending on your region.
    - By using the app, you grant us the right to collect certain data for improving the service.
    - We are committed to protecting your privacy and securing your data.
    - The app may include third-party content, for which we do not assume responsibility.
    - You agree to not use the app for unlawful purposes.

    More terms and conditions:
    
    - The user shall be responsible for ensuring that their use of the app complies with local laws.
    - We reserve the right to suspend or terminate accounts for any violations of the terms of service.
    - By using the app, you accept all risk related to the use of the information presented.
    
    Thank you for using the NEWS TODAY app.
    """
}

// MARK: - SwiftUI Preview for UIKit View
struct TermsViewController_Preview: PreviewProvider {
    static var previews: some View {
        TermsViewControllerWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct TermsViewControllerWrapper: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let termsViewController = TermsViewController(
            router: AppRouterImpl(
                factory: AppFactoryImpl(),
                navigation: UINavigationController()
            )
        )
        
        return termsViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
