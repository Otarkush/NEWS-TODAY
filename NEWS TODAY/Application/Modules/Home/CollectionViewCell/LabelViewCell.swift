//
//  LabelViewCell.swift
//  NEWS TODAY
//
//  Created by Daria Arisova on 31.10.2024.
//

import UIKit

class LabelViewCell: UICollectionViewCell {
    static let identifier = "LabelViewCell"
    
    public lazy var titleLabel = UILabel(
        numberOfLines: 1
    )
    
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
    
    func configure(label: NewHeadersTitles) {
        titleLabel.text = label.title
        titleLabel.font = label.font
        titleLabel.textColor = label.textColor
    }
      
    private func textLabelConstraints() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
}
