//
//  HeaderView.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 19.11.2024.
//


import UIKit

final class HeaderView: UIView {
    
    // MARK: - UI Elements
    private let browseLabel: UILabel = {
        let label = UILabel()
        label.text = "Browse"
        label.font = UIFont.InterSemiBold(ofSize: 24)
        label.textColor = .blackPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discoverLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover things of this world"
        label.font = .InterRegular(ofSize: 16)
        label.textColor = .grayPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchBlockStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.systemGray6
        stackView.layer.cornerRadius = 12
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return stackView
    }()
    
    public lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .grayPrimary
        let searchImage = UIImage.search
        button.setImage(searchImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.font = UIFont.InterMedium(ofSize: 16)
        textField.returnKeyType = .search
        textField.textColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        [browseLabel, discoverLabel, searchBlockStackView].forEach(addSubview)
        
        searchBlockStackView.addArrangedSubview(searchButton)
        searchBlockStackView.addArrangedSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            browseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            browseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            discoverLabel.topAnchor.constraint(equalTo: browseLabel.bottomAnchor, constant: 8),
            discoverLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            searchBlockStackView.topAnchor.constraint(equalTo: discoverLabel.bottomAnchor, constant: 16),
            searchBlockStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchBlockStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBlockStackView.heightAnchor.constraint(equalToConstant: 56),
            
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

