//
//  UIImage+Extension.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import UIKit

extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size:newSize)
        let image = renderer.image { _ in
            draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image
    }
}
