//
//  LanguageSelectionViewController.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 25.10.2024.
//

import UIKit
import SwiftUI
import Repository

final class LanguageSelectionViewController: UIViewController {

    // MARK: - Properties
    private let presenter: ProfileViewPresenter
    
    private var selectedLanguage: String = Drawing.defaultLanguage {
        didSet {
            updateButtonStates()
        }
    }

    // MARK: - UI Elements
    private let backButton = ActionButton(.darkBack)
    private let titleLabel = TitleLabel(text: Drawing.titleText)
    
    private let englishButton = ProfileButton(type: .chooseLanguage, title: Drawing.englishTitle)
    private let russianButton = ProfileButton(type: .chooseLanguage, title: Drawing.russianTitle)

    //MARK: - Init
    init(presenter: ProfileViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Drawing.initError)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setupView()
        setupConstraints()
        setupButtonTargets()
        updateButtonStates()
    }

    // MARK: - Setup UI
    private func setupView() {
        [backButton,
         titleLabel,
         englishButton,
         russianButton].forEach(view.addSubview)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Drawing.sidePadding),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            englishButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Drawing.buttonSpacing),
            englishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Drawing.sidePadding),
            englishButton.heightAnchor.constraint(equalToConstant: Drawing.buttonHeight),

            russianButton.topAnchor.constraint(equalTo: englishButton.bottomAnchor, constant: Drawing.buttonSpacing),
            russianButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Drawing.sidePadding),
            russianButton.heightAnchor.constraint(equalToConstant: Drawing.buttonHeight)
        ])
    }

    // MARK: - Setup Button Actions
    private func setupButtonTargets() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        englishButton.addTarget(self, action: #selector(englishButtonTapped), for: .touchUpInside)
        russianButton.addTarget(self, action: #selector(russianButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func backButtonTapped() {
        presenter.didTap(button: .backButton)
    }

    @objc private func englishButtonTapped() {
        selectedLanguage = Drawing.englishTitle
    }

    @objc private func russianButtonTapped() {
        selectedLanguage = Drawing.russianTitle
    }

    // MARK: - Update Button States
    private func updateButtonStates() {
        if selectedLanguage == Drawing.englishTitle {
            englishButton.backgroundColor = .blue
            englishButton.setTitleColor(.white, for: .normal)
            russianButton.backgroundColor = .grayLighter
            russianButton.setTitleColor(.darkGray, for: .normal)
        } else {
            russianButton.backgroundColor = .blue
            russianButton.setTitleColor(.white, for: .normal)
            englishButton.backgroundColor = .grayLighter
            englishButton.setTitleColor(.darkGray, for: .normal)
        }
    }
    // MARK: - Drawing Constants
    private enum Drawing {
        static let titleText = "Language"
        static let englishTitle = "English"
        static let russianTitle = "Русский"
        static let defaultLanguage = "English"
        static let initError = "init(coder:) has not been implemented"
        
        static let sidePadding: CGFloat = 16
        static let buttonHeight: CGFloat = 56
        static let buttonSpacing: CGFloat = 16
    }
}

//MARK: -  LanguageSelectionViewController + ProfileViewDelegate
extension LanguageSelectionViewController: ProfileViewDelegate {
    func updateUI(_ viewModel: ProfileViewModel) {}
}

// MARK: - SwiftUI Preview for UIKit View
struct LanguageSelectionViewController_Preview: PreviewProvider {
    static var previews: some View {
        LanguageSelectionViewControllerWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct LanguageSelectionViewControllerWrapper: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let router = AppRouterImpl(factory: AppFactoryImpl(), navigation: UINavigationController())
        
        let languageViewController = LanguageSelectionViewController(
            presenter:
                ProfileViewPresenterImpl(
                    networking: NewsRepository.shared, router: router))
        return languageViewController.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}


