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
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuration = .plain()
        setupButton()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        setupConstraints()
    }
    
    // MARK: - Setup Button Appearance
    private func setupButton() {
        
        configuration?.image = UIImage(named: "angleRight")!
        configuration?.imagePlacement = .trailing
        configuration?.imagePadding = 150
        
        setTitle("Terms & Conditions", for: .normal)
        titleLabel?.numberOfLines = 1
        titleLabel?.font = .systemFont(ofSize: 16)
        layer.cornerRadius = 12
        backgroundColor = .greyLighter
        tintColor = .darkGray
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints () {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 336),
            self.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    
    
    @objc private func buttonTapped() {
        print("Кнопка нажата!")
        
    }
}

private enum ButtonType {
    case language
    case terms
    case signOut
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
        let button = ProfileButton()
        
        
        let containerView = UIView()

        containerView.addSubview(button)
        
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 336),
            button.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

