//
//  ProfileButton.swift
//  ProfileView
//
//  Created by Daniil Murzin on 21.10.2024.
//

import UIKit
import SwiftUI

final class ProfileButton: UIButton {
    
    //MARK: - Type
    enum ButtonType {
        case changeLanguage
        case conditions
        case signOut
        case chooseLanguage
    }

    // MARK: - Init
    init(
        type: ButtonType,
        target: AnyObject? = nil,
        action: Selector? = nil,
        title: String? = nil) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.configuration = .plain()
        setupButton(type: type)
        setupConstraints()
        
        guard let action else { return }
        
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Button Appearance
    private func setupButton(type: ButtonType) {
        
        translatesAutoresizingMaskIntoConstraints = false
        configuration?.imagePlacement = .trailing
        configuration?.imagePadding = 200
        setTitleColor(.darkGray, for: .normal) 
        titleLabel?.numberOfLines = 1
        titleLabel?.font = .InterSemiBold(ofSize: 16)
        layer.cornerRadius = 12
        backgroundColor = .grayLighter
        tintColor = .darkGray
        
        switch type {
        case .changeLanguage:
            setTitle("Language", for: .normal)
            configuration?.image = .angleRight
        case .conditions:
            setTitle("Terms and Conditions", for: .normal)
            configuration?.image = .angleRight
            configuration?.imagePadding = 100
        case .signOut:
            setTitle("Sign Out", for: .normal)
            configuration?.image = .signOut
        case .chooseLanguage:
            configuration?.image = .check
        }
    }
    
    private func setupConstraints () {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 336),
            self.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
