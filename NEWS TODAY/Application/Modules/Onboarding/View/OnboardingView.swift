//
//  OnboardingView.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 30.10.2024.
//

import UIKit
import SwiftUI

//MARK: - Protocols
protocol OnboardingView: UIView {
    func setPageLabelTransform(transform: CGAffineTransform)
    var imageView: UIImageView { get }
}

class OnboardingViewImpl: UIView, OnboardingView {
    
    internal let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 16
        return image
    }()
    
    internal let firstToKnowLabel: UILabel = {
        let label = UILabel()
        label.font = .InterSemiBold(ofSize: 24)
        label.textColor = .blackPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .InterRegular(ofSize: 16)
        label.textColor = .greyPrimary
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .purplePrimary
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [imageView, firstToKnowLabel, descriptionLabel, nextButton].forEach(addSubview)
    }

    func setupSlideUI(
        image: String,
        title: String?,
        description: String,
        nextButtonTitle: String,
        target: AnyObject?,
        action: Selector?
    ) {
            
        imageView.image = UIImage(named: image)
        firstToKnowLabel.text = title
        descriptionLabel.text = description
        nextButton.setTitle(nextButtonTitle, for: .normal)
        guard let action else { return }
        nextButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    public func setPageLabelTransform(transform: CGAffineTransform) {
        imageView.transform = transform
    }
    
    // MARK: - setupConstraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55),
            
            firstToKnowLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            firstToKnowLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: firstToKnowLabel.bottomAnchor, constant: 15),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 220),
            
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 330),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
