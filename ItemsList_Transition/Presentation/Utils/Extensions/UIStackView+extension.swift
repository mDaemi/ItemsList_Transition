//
//  UIStackView+extension.swift
//  ItemsList_Transition
//
//  Created by MDA on 17/07/2023.
//

import UIKit

extension UIStackView {
    func configure(withAxis axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, spacing: CGFloat, distribution: UIStackView.Distribution = .fillEqually) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.distribution = distribution
    }
}
