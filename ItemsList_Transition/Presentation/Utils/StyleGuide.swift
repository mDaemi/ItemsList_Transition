//
//  StyleGuide.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import UIKit

/*
  File purpose: Color and font styles reference
 */

extension UIColor {
    static let backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.00)
    static let buttonBackgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.96, alpha :1.00)
    static let borderColor: UIColor =  UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 0.3)
    static let lightTextColor: UIColor = .gray
    static let darkTextColor: UIColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
    static let red: UIColor = UIColor(red: 0.65, green: 0.0, blue: 0.0, alpha: 1)
}

extension CGFloat {
    static let heroTextSize: CGFloat = 21.0
    static let headerTextSize: CGFloat = 16.0
    static let subHeaderTextSize: CGFloat = 15.0
    static let smallTextSize: CGFloat = 12.0
}

extension UILabel {
  
    func configureHeaderLabel(withText text: String) {
        configure(withText: text, size: .headerTextSize, alignment: .left, lines: 0, weight: .bold, color: UIColor.darkTextColor)
    }
    
    func configureSubHeaderLabel(withText text: String) {
        configure(withText: text, size: .headerTextSize, alignment: .left, lines: 0, weight: .medium, color: UIColor.lightTextColor)
    }

    func configureHeroLabel(withText text: String) {
        configure(withText: text, size: .heroTextSize, alignment: .left, lines: 0, weight: .heavy, color: UIColor.darkTextColor)
    }

    func configureAppSubHeaderLabel(withText text: String) {
        configure(withText: text, size: .smallTextSize, alignment: .left, lines: 0, weight: .regular, color: UIColor.lightTextColor)
    }

    private func configure(withText newText: String,
                         size: CGFloat,
                         alignment: NSTextAlignment,
                         lines: Int,
                         weight: UIFont.Weight,
                         color: UIColor) {
        text = newText
        font = UIFont.systemFont(ofSize: size, weight: weight)
        textAlignment = alignment
        numberOfLines = lines
        lineBreakMode = .byTruncatingTail
        textColor = color
    }
}


