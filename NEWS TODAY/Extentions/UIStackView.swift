//
//  UIStackView.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 28.10.2024.
//


import UIKit

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis){
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.distribution = .fillEqually
        self.spacing = 10
        self.alignment = .fill
    }
}
