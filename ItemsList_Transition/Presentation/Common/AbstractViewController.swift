//
//  AbstractViewController.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import UIKit
import Combine
import Foundation

class AbstractViewController: UIViewController {
    // MARK: - Constants
    private let snackHeight: CGFloat = 64

    // MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    private var snack: SnackView?
    private var snackLeftConstraint: NSLayoutConstraint?
    private var snackBottomConstraint: NSLayoutConstraint?
    private var snackRightConstraint: NSLayoutConstraint?
    private var snackHeightConstraint: NSLayoutConstraint?

    // MARK: - Inherit
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Public - Snack
    func displaySnack(text: String, closingTime: TimeInterval? = 3) {

        if self.snack == nil {
            snack = SnackView()
            snack!.layer.cornerRadius = constraint.corderRadius
            self.view.addSubview(snack!)
            applySnackConstraint(to: snack!)
            self.view.layoutIfNeeded()
        } else {
            // cancel the previous perform to avoid closing before its time
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.closeSnack), object: nil)
            self.snackBottomConstraint?.constant = snackHeight + 30
            self.snack?.layoutIfNeeded()
        }

        snack?.text = text

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseInOut,
                       animations: {
                        self.snackBottomConstraint?.constant = -10
                        self.view?.layoutIfNeeded()
        }, completion: {
            (_: Bool) in
            if let closingTime = closingTime {
                self.perform(#selector(self.closeSnack), with: nil, afterDelay: closingTime)
            }
        })
    }

    // MARK: - Private - Snack
    private func applySnackConstraint(to snack: UIView) {
        snack.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        snackBottomConstraint = NSLayoutConstraint(item: snack,
                                                   attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem: snack.superview?.safeAreaLayoutGuide,
                                                   attribute: .bottom,
                                                   multiplier: 1,
                                                   constant: snackHeight + 30)
        snackBottomConstraint!.isActive = true
        constraints.append(snackBottomConstraint!)

        snackLeftConstraint = NSLayoutConstraint(item: snack,
                                                 attribute: .leading,
                                                 relatedBy: .equal,
                                                 toItem: snack.superview,
                                                 attribute: .leading,
                                                 multiplier: 1,
                                                 constant: 10)
        snackLeftConstraint!.isActive = true
        constraints.append(snackLeftConstraint!)

        snackRightConstraint = NSLayoutConstraint(item: snack,
                                                  attribute: .trailing,
                                                  relatedBy: .equal,
                                                  toItem: snack.superview,
                                                  attribute: .trailing,
                                                  multiplier: 1,
                                                  constant: -10)
        snackRightConstraint!.isActive = true
        constraints.append(snackRightConstraint!)

        snackHeightConstraint = NSLayoutConstraint(item: snack,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1,
                                                   constant: snackHeight)
        snackHeightConstraint!.isActive = true
        constraints.append(snackHeightConstraint!)
    }
    
    @objc func closeSnack() {
        if let snackBar = snack {
            closeSnackBar(snackBar)
        }
    }
}

// MARK: - PSnackBarView
extension AbstractViewController: PSnackBarView {
    
    func closeSnackBar(_ snackBar: SnackView) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseInOut,
                       animations: {
                        self.snackBottomConstraint?.constant = self.snackHeight + 50
                        self.view?.layoutIfNeeded()
        }, completion: {
            (_: Bool) in
            self.snack?.removeFromSuperview()
            self.snack = nil
        })
    }
}

