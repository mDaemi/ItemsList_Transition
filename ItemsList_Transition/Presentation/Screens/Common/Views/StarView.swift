//
//  StarView.swift
//  ItemsList_Transition
//
//  Created by MDA on 17/07/2023.
//

import UIKit

class StarView: UIView {
    
    var starRating: CGFloat = 0
    
    lazy var starRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.configure(withAxis: .horizontal, alignment: .fill, spacing: 4)
        return stackView
    }()
    
    lazy var starFilledImage: UIImage = {
        return UIImage(named: "star-filled")!
    }()
    
    lazy var starEmptyImage: UIImage = {
        return UIImage(named: "star-empty")!
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(starRating: Float) {
        self.starRating = CGFloat(starRating)
        setupStarRatingView()
    }
    
    private func setupStarRatingView() {
        for subview in starRatingStackView.subviews {
            subview.removeFromSuperview()
        }
        let filledStars = Int(starRating)
        let hasHalfStar = starRating.truncatingRemainder(dividingBy: 1) != 0
        let emptyStars = hasHalfStar ? 5 - filledStars - 1 : 5 - filledStars
        
        // Add the filled stars
        for _ in 0..<filledStars {
            let imageView = UIImageView(image: starFilledImage)
            starRatingStackView.addArrangedSubview(imageView)
        }
        
        // Add the half star if necessary
        if hasHalfStar {
            let halfStarImageView = UIImageView(image: UIImage(named: "half-star")!)
            starRatingStackView.addArrangedSubview(halfStarImageView)
        }
        
        // Add the empty stars
        for _ in 0..<emptyStars {
            let imageView = UIImageView(image: starEmptyImage)
            starRatingStackView.addArrangedSubview(imageView)
        }
        
        // Add the stack view to the view
        addSubview(starRatingStackView)
        
        // Set constraints for the stack view
        NSLayoutConstraint.activate([
            starRatingStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            starRatingStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            starRatingStackView.widthAnchor.constraint(equalTo: widthAnchor),
            starRatingStackView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
