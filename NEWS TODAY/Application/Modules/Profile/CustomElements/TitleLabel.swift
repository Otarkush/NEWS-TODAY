//
//  TitleLabel.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 25.10.2024.
//


import UIKit

final class TitleLabel: UILabel {
    
    // MARK: - Init
    init(text: String, fontSize: CGFloat = 24) {
        super.init(frame: .zero)
        setupLabel(text: text, fontSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Label Appearance
    private func setupLabel(text: String, fontSize: CGFloat) {
        self.text = text
        self.font = .InterSemiBold(ofSize: fontSize)
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
