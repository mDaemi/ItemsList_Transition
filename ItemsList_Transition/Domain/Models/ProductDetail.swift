//
//  ProductDetail.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

struct ProductDetail {
    var productId: Int?
    var salePrice: Float?
    var newBestPrice: Float?
    var usedBestPrice: Int?
    var quality: String?
    var type: String?
    var sellerComment: String?
    var headline: String?
    var description: String?
    var categories: [String]?
    var globalRating: globalRating?
    var images: [ImageURL]?
}

struct ImageURL {
    var size: String?
    var url: String?
}

struct globalRating {
    var score: Float?
    var nbReviews: Int?
}
