//
//  ProductDetail.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

public struct ProductDetail {
    var productId: Int
    var salePrice: Float?
    var newBestPrice: Float?
    var usedBestPrice: Int?
    var quality: String?
    var type: String?
    var sellerComment: String?
    var headline: String?
    var description: String?
    var categories: [String]?
    var globalRating: GlobalRating?
    var images: [ImageURL]
}

public struct ImageURL {
    var size: String
    var url: String
}

public struct GlobalRating {
    var score: Float?
    var nbReviews: Int?
}
