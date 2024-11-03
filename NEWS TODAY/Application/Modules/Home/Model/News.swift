//
//  News.swift
//  NEWS TODAY
//
//  Created by Daria Arisova on 03.11.2024.
//

import UIKit

struct News: Hashable {
    let id: Int
    let category: String
    let title: String
    let img: UIImage
    let favorite: Bool
}
