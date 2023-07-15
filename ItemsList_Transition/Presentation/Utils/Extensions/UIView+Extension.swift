//
//  UIView+Extension.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import UIKit

extension UIView {
    // MARK: Constraints
    @discardableResult func constraintToSuperview(top: CGFloat? = 0,
                                                  bottom: CGFloat? = 0,
                                                  left: CGFloat? = 0,
                                                  right: CGFloat? = 0,
                                                  width: CGFloat? = nil,
                                                  height: CGFloat? = nil,
                                                  centerX: CGFloat? = nil,
                                                  centerY: CGFloat? = nil) -> NSLayoutConstraint? {
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []

        // top and bottom
        if top != nil {
            let topConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: self.superview,
                                                   attribute: .top,
                                                   multiplier: 1,
                                                   constant: top!)
            topConstraint.isActive = true
            constraints.append(topConstraint)
        }

        if bottom != nil {
            let bottomConstraint = NSLayoutConstraint(item: self,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: self.superview,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: -bottom!)
            bottomConstraint.isActive = true
            constraints.append(bottomConstraint)
        }

        // left and right
        var leftConstraint: NSLayoutConstraint?
        if left != nil {
            leftConstraint = NSLayoutConstraint(item: self,
                                                attribute: .leading,
                                                relatedBy: .equal,
                                                toItem: self.superview,
                                                attribute: .leading,
                                                multiplier: 1,
                                                constant: left!)
            leftConstraint!.isActive = true
            constraints.append(leftConstraint!)
        }

        if right != nil {
            let rightConstraint = NSLayoutConstraint(item: self,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: self.superview,
                                                     attribute: .trailing,
                                                     multiplier: 1,
                                                     constant: right!)
            rightConstraint.isActive = true
            constraints.append(rightConstraint)
        }

        if width != nil {
            let widthConstraint = NSLayoutConstraint(item: self,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1,
                                                     constant: width!)
            widthConstraint.isActive = true
            constraints.append(widthConstraint)
        }

        if height != nil {
            let heightConstraint = NSLayoutConstraint(item: self,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1,
                                                      constant: height!)
            heightConstraint.isActive = true
            constraints.append(heightConstraint)
        }

        if centerX != nil {
            let centerXConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .centerX,
                                                       relatedBy: .equal,
                                                       toItem: self.superview,
                                                       attribute: .centerX,
                                                       multiplier: 1,
                                                       constant: centerX!)
            centerXConstraint.isActive = true
            constraints.append(centerXConstraint)
        }

        if centerY != nil {
            let centerYConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .centerY,
                                                       relatedBy: .equal,
                                                       toItem: self.superview,
                                                       attribute: .centerY,
                                                       multiplier: 1,
                                                       constant: centerY!)
            centerYConstraint.isActive = true
            constraints.append(centerYConstraint)
        }

        self.superview?.addConstraints(constraints)

        return leftConstraint
    }
    
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat? = 0, height: CGFloat? = 0) {
        
        let insets = self.safeAreaInsets
        let topInset = insets.top
        let bottomInset = insets.bottom
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if let height = height, height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width, width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}

