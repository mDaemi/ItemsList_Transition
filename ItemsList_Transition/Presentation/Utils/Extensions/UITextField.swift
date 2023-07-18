//
//  UITextField.swift
//  ItemsList_Transition
//
//  Created by MDA on 18/07/2023.
//

import Foundation
import Combine
import UIKit

extension UITextField {

    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }
}
