//
//  ProductDetail+Mapper.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import Foundation

extension ProductDetail {
    func toPresentation() -> ProductDetailUIModel {
        return ProductDetailUIModel(productId: self.productId,
                                    salePrice: (self.salePrice != nil) ? self.salePrice!.toLocalCurrency() : "-",
                                    newBestPrice: (self.newBestPrice != nil) ? self.newBestPrice!.toLocalCurrency() : "-",
                                    usedBestPrice: (self.usedBestPrice != nil) ? self.usedBestPrice!.toLocalCurrency() : "-",
                                    quality: self.quality ?? "-",
                                    type: self.type ?? "-",
                                    sellerComment: self.sellerComment ?? "",
                                    headline: self.headline ?? "",
                                    description: self.description ?? "",
                                    categories: self.categories ?? [],
                                    score: self.globalRating?.score ?? -1,
                                    nbReviews: (self.globalRating?.nbReviews != nil) ? ((self.globalRating!.nbReviews != nil) ? String(self.globalRating!.nbReviews!) : "") : "",
                                    images: self.images.map { $0.toPresentation() })
    }
}

extension ImageURL {
    func toPresentation() -> ImageURLUIModel {
        return ImageURLUIModel(size: self.size,
                               url: self.url)
    }
}
