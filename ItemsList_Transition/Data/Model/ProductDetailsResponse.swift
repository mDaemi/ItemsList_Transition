//
//  ProductDetailResponse.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

struct ProductDetailsResponse: Decodable {
    var productId: Int?
    var salePrice: Float?
    var newBestPrice: Float?
    var usedBestPrice: Int?
    var seller: SellerResponse?
    var quality: String?
    var type: String?
    var sellerComment: String?
    var headline: String?
    var description: String?
    var categories: [String]?
    var globalRating: GlobalRatingResponse?
    var images: [ImagesURLsResponse]?
}

struct ImagesURLsResponse: Decodable {
    var imagesUrls: ImageEntryResponse?
    var id: Int?
}

struct ImageEntryResponse: Decodable {
    var entry: [ImageURLResponse]?
}

struct ImageURLResponse: Decodable {
    var size: String?
    var url: String?
}

struct SellerResponse: Decodable {
    var id: Int?
    var login: String?
}

struct GlobalRatingResponse: Decodable {
    var score: Float?
    var nbReviews: Int?
}
