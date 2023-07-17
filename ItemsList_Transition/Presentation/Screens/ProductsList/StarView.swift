//
//  StarView.swift
//  ItemsList_Transition
//
//  Created by MDA on 17/07/2023.
//

import UIKit

class StarView: UIView {
    
    lazy var starRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    lazy var starFilledImage: UIImage = {
        // Replace with your star-filled image
        return UIImage(named: "star-filled")!
    }()
    
    lazy var starEmptyImage: UIImage = {
        // Replace with your star-empty image
        return UIImage(named: "star-empty")!
    }()
    
    lazy var starRating: CGFloat = 4.5
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupStarRatingView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStarRatingView() {
        // Determine the number of filled and empty stars
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
            let halfStarImageView = UIImageView(image: starFilledImage)
            halfStarImageView.contentMode = .left
            halfStarImageView.clipsToBounds = true
            halfStarImageView.frame.size.width = starFilledImage.size.width / 2
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
            starRatingStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
