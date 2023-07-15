//
//  ItemsResponse.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

struct ProductsResponse: Decodable {
    var totalResultProductsCount: Int?
    var resultProductsCount: Int?
    var pageNumber: Int?
    var title: String?
    var maxProductsPerPage: Int?
    var maxPageNumber: Int?
    var products: [ProductResponse]?
}

struct ProductResponse: Decodable {
    var id: Int?
    var newBestPrice: Float?
    var usedBestPrice: Int?
    var headline: String?
    var reviewsAverageNote: Float?
    var nbReviews: Int?
    var categoryRef: Int?
    var imagesUrls: [String]?
}
