//
//  UIButton.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 28.10.2024.
//

import UIKit

extension UIButton {
    
    convenience init(initBackgroundColor: UIColor) {
        
        self.init(type: .custom)
        
        setTitleColor(.greyDarker, for: .normal)
        backgroundColor = initBackgroundColor
        titleLabel?.font = .InterSemiBold(ofSize: 20)
        layer.cornerRadius = 12
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderColor = UIColor.greyLight.cgColor
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    convenience init(initPurpleButton: UIColor, text: String) {
        
        self.init(type: .system)
        
        setTitle(text, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.InterRegular(ofSize: 15)
        tintColor = .white
        widthAnchor.constraint(equalToConstant: 320).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundColor = UIColor.purplePrimary
        translatesAutoresizingMaskIntoConstraints = false
    }
}
