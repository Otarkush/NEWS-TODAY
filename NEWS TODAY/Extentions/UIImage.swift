//
//  UIImage.swift
//  NEWS TODAY
//
//  Created by Daniil Murzin on 05.11.2024.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }
}
