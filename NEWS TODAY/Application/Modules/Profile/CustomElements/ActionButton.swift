//
//  BackButton.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 25.10.2024.
//

import UIKit

final class ActionButton: UIButton {
    
    enum ButtonType {
        case darkBack
        case back
        case share
        case favorite
    }
    
    // MARK: - Init
    init(
        _ buttonType: ButtonType,
        target: AnyObject? = nil,
        action: Selector? = nil
    ) {
        super.init(frame: .zero)
        setupButton(buttonType: buttonType)
        setupConstraints()

        guard let action = action else { return }
        
        addTarget(target, action: action, for: .touchUpInside)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Button Appearance
    private func setupButton(buttonType: ButtonType) {
        translatesAutoresizingMaskIntoConstraints = false
        
        tintColor = .white
        backgroundColor = .clear
        
        switch buttonType {
            case .back:
            setImage(UIImage.leftIcon, for: .normal)
        case .share:
            setImage(UIImage.shareIcon, for: .normal)
        case .favorite:
            setImage(UIImage.bookmarkIcon, for: .normal)
        case .darkBack:
            tintColor = .greyDarker
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 44),
            self.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

