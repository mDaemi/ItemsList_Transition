//
//  ProductUIModel.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import Foundation

class ProductUIModel {
    var id: Int
    var newBestPrice: String
    var usedBestPrice: String
    var headline: String
    var reviewsAverageNote: Float
    var nbReviews: String
    var imageUrl: String? = nil
    var viewMode: CardViewMode = .card
    
    init(id: Int, newBestPrice: String, usedBestPrice: String, headline: String, reviewsAverageNote: Float, nbReviews: String, imageUrl: String? = nil, viewMode: CardViewMode = .card) {
        self.id = id
        self.newBestPrice = newBestPrice
        self.usedBestPrice = usedBestPrice
        self.headline = headline
        self.reviewsAverageNote = reviewsAverageNote
        self.nbReviews = nbReviews
        self.imageUrl = imageUrl
        self.viewMode = viewMode
    }
}

enum CardViewMode {
    case full
    case card
}
