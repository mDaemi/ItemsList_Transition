//
//  ProductDetailUIModel.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import Foundation

struct ProductDetailUIModel {
    var productId: Int
    var salePrice: String
    var newBestPrice: String
    var usedBestPrice: String
    var quality: String
    var type: String
    var sellerComment: String
    var headline: String
    var description: String
    var categories: [String]
    var score: Float
    var nbReviews: String
    var images: [ImageURLUIModel]
}

struct ImageURLUIModel {
    var size: String
    var url: String
}
