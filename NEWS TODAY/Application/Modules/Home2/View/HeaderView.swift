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
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray
        let searchImage = UIImage.search
        button.setImage(searchImage, for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
        addSubview(browseLabel)
        addSubview(discoverLabel)
        addSubview(searchBlockStackView)
        
        searchBlockStackView.addArrangedSubview(searchButton)
        searchBlockStackView.addArrangedSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            // Browse Label
            browseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            browseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // Discover Label
            discoverLabel.topAnchor.constraint(equalTo: browseLabel.bottomAnchor, constant: 8),
            discoverLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // Search Bar
            searchBlockStackView.topAnchor.constraint(equalTo: discoverLabel.bottomAnchor, constant: 16),
            searchBlockStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchBlockStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBlockStackView.heightAnchor.constraint(equalToConstant: 56),
            
            // Search Button
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Button Actions
    @objc private func searchButtonTapped() {
        print("Search button tapped")
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let query = textField.text else { return }
        print("Search query: \(query)")
    }
}

