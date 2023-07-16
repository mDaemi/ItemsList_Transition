//
//  ProductsListResponse+Mapper.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

extension ProductResponse {
    func toDomain() -> Product? {
        if let id = self.id {
            return Product(id: id,
                           newBestPrice: self.newBestPrice,
                           usedBestPrice: self.usedBestPrice,
                           headline: self.headline,
                           reviewsAverageNote: self.reviewsAverageNote,
                           nbReviews: self.nbReviews,
                           imagesUrls: self.imagesUrls)
        }
        return nil
    }
}
