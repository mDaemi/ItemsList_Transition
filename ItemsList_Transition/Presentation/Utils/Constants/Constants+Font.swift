//
//  Constants+Font.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import UIKit

typealias FontConstant = Constants.FontConstant

extension Constants {
    public enum FontConstant: String {
        case boldBig = "boldBig"
        case boldMedium = "boldMedium"
        case boldNormal = "boldNormal"
        case mediumBig = "mediumBig"
        case mediumNormal = "mediumNormal"
        case mediumSuperTiny = "mediumSuperTiny"
        case regularMedium = "regularMedium"
        case regularNormal = "regularNormal"
        case regularSmall = "regularSmall"
        case regularTiny = "regularTiny"
        
        public func getFont() -> UIFont {
            var font: UIFont = UIFont.systemFont(ofSize: 14)
            var device: UIUserInterfaceIdiom = .phone
            if UIDevice.current.userInterfaceIdiom == .pad {
                device = .pad
            }
            switch self {
            case .boldBig:
                font = UIFont.boldSystemFont(ofSize: (device == .pad) ? 40 : 20)
            case .boldMedium:
                font = UIFont.boldSystemFont(ofSize: (device == .pad) ? 32 : 16)
            case .boldNormal:
                font = UIFont.boldSystemFont(ofSize: (device == .pad) ? 26 : 13)
            case .mediumBig:
                font = UIFont.systemFont(ofSize: (device == .pad) ? 40 : 20, weight: UIFont.Weight.medium)
            case .mediumNormal:
                font = UIFont.systemFont(ofSize: (device == .pad) ? 32 : 16, weight: UIFont.Weight.medium)
            case .mediumSuperTiny:
                font = UIFont.systemFont(ofSize: (device == .pad) ? 20 : 10, weight: UIFont.Weight.medium)
            case .regularMedium:
                font = UIFont.systemFont(ofSize: (device == .pad) ? 36 : 18)
            case .regularNormal:
                font = UIFont.systemFont(ofSize: (device == .pad) ? 32 : 16)
            case .regularSmall:
                font = UIFont.systemFont(ofSize: (device == .pad) ? 24 : 12)
            case .regularTiny:
                font = UIFont.systemFont(ofSize: (device == .pad) ? 22 : 11)
            }
            return font
        }
    }
}
