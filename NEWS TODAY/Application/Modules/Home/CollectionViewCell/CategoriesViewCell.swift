//
//  CategoriesViewCell.swift
//  NEWS TODAY
//
//  Created by Daria Arisova on 31.10.2024.
//

import UIKit

class CategoriesViewCell: UICollectionViewCell {
    static let identifier = "CategoriesViewCell"
    
    public lazy var button: UIButton = {
        let element = UIButton(initBrowsecategoriesButton: .greyLighter)
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
      }
    
    private func commonInit() {
        textLabelConstraints()
    }
    
    func configure(category: /*NewsCategory*/Category) {
        button.setTitle(category.name, for: .normal)
    }
      
    private func textLabelConstraints() {
        addSubview(button)
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
//            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
}
