//
//  SnackView.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import UIKit

protocol PSnackBarView: NSObjectProtocol {
    func closeSnackBar(_ snackBar: SnackView)
}

final class SnackView: UIView {
    
    // MARK: - Properties
    private let label : UILabel = {
        let lbl = UILabel()
        lbl.clipsToBounds = true
        return lbl
    }()
   
    private var roundedView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var text: String? {
        didSet {
           label.configureAppHeaderLabel(withText: text ?? "")
        }
    }
    
    // MARK: - Inherit
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.zPosition = 1
        roundedView.addSubview(label)
        label.anchor(top: roundedView.topAnchor, left: roundedView.leftAnchor, bottom: roundedView.bottomAnchor, right: roundedView.rightAnchor, paddingTop: constraint.padding, paddingLeft: 16, paddingBottom: constraint.padding, paddingRight: 16)
        addSubview(roundedView)
        roundedView.constraintToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded()
        updateRounded()
    }
    
    // MARK: - Actions
    fileprivate func updateRounded() {
        let radius = 5
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: roundedView.bounds,
                                byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: radius, height: radius))
        maskLayer.path = path.cgPath
        
        roundedView.layer.mask = maskLayer
    }
}

