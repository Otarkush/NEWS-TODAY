//
//  Array.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 23.11.2024.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
