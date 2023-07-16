//
//  ProductUIModel.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import Foundation

struct ProductUIModel {
    var id: Int
    var newBestPrice: String
    var usedBestPrice: String
    var headline: String
    var reviewsAverageNote: Float
    var nbReviews: String
    var imageUrl: String?
    var viewMode: CardViewMode = .card
    var backgroundType: BackgroundType = .light
}

enum CardViewMode {
    case full
    case card
}
