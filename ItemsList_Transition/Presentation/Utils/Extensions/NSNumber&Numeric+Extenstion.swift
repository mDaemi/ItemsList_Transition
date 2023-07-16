//
//  Float+Extenstion.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import Foundation

extension NSNumber {
    func toLocalCurrency(fractDigits: Int = 2) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = fractDigits
        return formatter.string(from: self)
    }
}

extension Numeric {
    func toLocalCurrency(fractDigits: Int = 2) -> String {
        return (self as? NSNumber)?.toLocalCurrency(fractDigits: fractDigits) ?? "-"
    }
}
