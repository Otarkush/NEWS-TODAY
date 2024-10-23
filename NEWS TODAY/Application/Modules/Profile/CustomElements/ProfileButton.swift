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

    // MARK: - Init
    init(type: ButtonType, target: Any?, action: Selector) {
        super.init(frame: .zero)
        self.configuration = .plain()
        setupButton(type: type)
        setupConstraints()
        
        addTarget(target, action: action, for: .touchUpInside)
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
        case .conditions:
            setTitle("Terms and Conditions", for: .normal)
            configuration?.imagePadding = 100
        case .signOut:
            setTitle("Sign Out", for: .normal)
            configuration?.image = UIImage.signOut
        }
    }
    
    private func setupConstraints () {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 336),
            self.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
