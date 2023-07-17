//
//  StyleGuide.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import UIKit

enum BackgroundType: String {
    case light
    case dark
    
    var titleTextColor: UIColor {
        switch self {
        case .dark:
            return .lightTitleTextColor
        case .light:
            return .darkTitleTextColor
        }
    }
    
    var subtitleTextColor: UIColor {
        switch self {
        case .dark:
            return .lightSubtitleTextColor
        case .light:
            return .darkSubtitleTextColor
        }
    }
}

extension UIColor {
    static let backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.00)
    static let buttonBackgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.96, alpha :1.00)
    static let borderColor: UIColor =  UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 0.3)
    static let heroTextColor: UIColor = .white
    static let lightSubtitleTextColor: UIColor = UIColor.white.withAlphaComponent(0.8)
    static let lightTitleTextColor: UIColor = .white
    static let darkSubtitleTextColor: UIColor = .gray
    static let darkTitleTextColor: UIColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
}

extension CGFloat {
    static let heroTextSize: CGFloat = 50.0
    static let headerTextSize: CGFloat = 16.0
    static let subHeaderTextSize: CGFloat = 15.0
    static let appHeaderTextSize: CGFloat = 15.0
    static let smallTextSize: CGFloat = 12.0
}

extension UILabel {
  
    func configureHeaderLabel(withText text: String) {
        configure(withText: text, size: .headerTextSize, alignment: .left, lines: 0, weight: .bold)
    }

    func configureSubHeaderLabel(withText text: String) {
        configure(withText: text, size: .subHeaderTextSize, alignment: .left, lines: 0, weight: .semibold)
    }

    func configureHeroLabel(withText text: String) {
        configure(withText: text, size: .heroTextSize, alignment: .left, lines: 0, weight: .heavy)
    }

    func configureAppHeaderLabel(withText text: String){
        configure(withText: text, size: .appHeaderTextSize, alignment: .left, lines: 2, weight: .medium)
    }

    func configureAppSubHeaderLabel(withText text: String) {
        configure(withText: text, size: .smallTextSize, alignment: .left, lines: 2, weight: .regular)
    }

    private func configure(withText newText: String,
                         size: CGFloat,
                         alignment: NSTextAlignment,
                         lines: Int,
                         weight: UIFont.Weight) {
        text = newText
        font = UIFont.systemFont(ofSize: size, weight: weight)
        textAlignment = alignment
        numberOfLines = lines
        lineBreakMode = .byTruncatingTail
    }
}

extension UIImageView {
    func configureAppIconView(forImage appImage: UIImage, size: CGFloat) {
        image = appImage
        contentMode = .scaleAspectFit
        layer.cornerRadius = size/5.0
        layer.borderColor = UIColor.borderColor.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
    }
}

extension UIStackView {
    func configure(withAxis axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, spacing: CGFloat, distribution: UIStackView.Distribution = .fillEqually) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.distribution = distribution
    }
}


