//
//  ProfileButton.swift
//  ProfileView
//
//  Created by Daniil Murzin on 21.10.2024.
//

import UIKit
import SwiftUI

#warning("Поменять шрифты, цвета")
class ProfileButton: UIButton {
    
    //MARK: - Type
    enum ButtonType {
        case changeLanguage
        case conditions
        case signOut
    }
    
    //MARK: - Properties
    
    // MARK: - Init
    init(type: ButtonType) {
        super.init(frame: .zero)
        self.configuration = .plain()
        setupButton(type: type)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Button Appearance
    private func setupButton(type: ButtonType) {
        
        translatesAutoresizingMaskIntoConstraints = false
        configuration?.image = UIImage.angleRight
        configuration?.imagePlacement = .trailing
        configuration?.imagePadding = 200
        
        titleLabel?.numberOfLines = 1
        titleLabel?.font = .systemFont(ofSize: 16)
        layer.cornerRadius = 12
        backgroundColor = .greyLighter
        tintColor = .darkGray
        
        switch type {
        case .changeLanguage:
            setTitle("Language", for: .normal)
            addTarget(self, action: #selector(changeLanguageTapped), for: .touchUpInside)
        case .conditions:
            setTitle("Terms and Conditions", for: .normal)
            addTarget(self, action: #selector(conditionsTapped), for: .touchUpInside)
            configuration?.imagePadding = 100
        case .signOut:
            setTitle("Sign Out", for: .normal)
            addTarget(self, action: #selector(SignOutTapped), for: .touchUpInside)
            configuration?.image = UIImage.signOut
        }
    }
    
    private func setupConstraints () {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 336),
            self.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc private func changeLanguageTapped() {
        print("Кнопка Language нажата!")
    }
    
    @objc private func conditionsTapped() {
        print("Кнопка Conditions нажата!")
        
    }
    
    @objc private func SignOutTapped() {
        print("Кнопка SignOut нажата!")
        
    }
}

// MARK: - SwiftUI Preview for UIKit View
struct ProfileButton_Preview: PreviewProvider {
    static var previews: some View {
        ProfileButtonWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct ProfileButtonWrapper: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let button = ProfileButton(type: .conditions)
        
        
        let containerView = UIView()

        containerView.addSubview(button)
        
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 336),
            button.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

