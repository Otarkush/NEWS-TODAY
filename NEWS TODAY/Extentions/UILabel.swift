//
//  UILabel + MakeLabel.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 26.10.2024.
//

import UIKit

extension UILabel {

    convenience init(
        text: String? = "",
        font: UIFont? = nil,
        textColor: UIColor = .white,
        numberOfLines: Int = 0
    ) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
