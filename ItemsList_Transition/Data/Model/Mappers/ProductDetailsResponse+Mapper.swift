//
//  ProductDetailsResponse+Mapper.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

extension ProductDetailsResponse {
    func toDomain() -> ProductDetail? {
        if let id = self.productId {
            return ProductDetail(productId: id,
                                 salePrice: self.salePrice,
                                 newBestPrice: self.newBestPrice,
                                 usedBestPrice: self.usedBestPrice,
                                 quality: self.quality,
                                 type: self.type,
                                 sellerComment: self.sellerComment,
                                 headline: self.headline,
                                 description: self.description,
                                 categories: self.categories,
                                 globalRating: self.globalRating?.toDomain(),
                                 images: self.getImageURLs())
        }
        return nil
    }
    
    private func getImageURLs() -> [ImageURL] {
        if let imageURLs = self.images.map({ $0.map { $0.imagesUrls?.entry }}) {
            return imageURLs.flatMap { $0.map { $0.map { $0.toDomain()}} ?? []}
        }
        return []
    }
}

extension ImageURLResponse {
    func toDomain() -> ImageURL {
        return ImageURL(size: self.size!, url: self.size!)
    }
}

extension GlobalRatingResponse {
    func toDomain() -> GlobalRating {
        return GlobalRating(score: self.score, nbReviews: self.nbReviews)
    }
}
