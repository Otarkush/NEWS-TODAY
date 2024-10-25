//
//  BackButton.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 25.10.2024.
//

import UIKit

final class BackButton: UIButton {
    
    // MARK: - Init
    init(target: AnyObject? = nil, action: Selector? = nil) {
        super.init(frame: .zero)
        setupButton()
        setupConstraints()

        guard let action = action else { return }
        
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Button Appearance
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: "arrow.left"), for: .normal)
        tintColor = .greyDarker
        backgroundColor = .clear
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 44),
            self.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

