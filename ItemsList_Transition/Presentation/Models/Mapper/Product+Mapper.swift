//
//  Product+Mapper.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import Foundation

extension Product {
    func toPresentation() -> ProductUIModel {
        return ProductUIModel(id: self.id,
                              newBestPrice: (self.newBestPrice != nil) ? self.newBestPrice!.toLocalCurrency() : "-",
                              usedBestPrice: (self.usedBestPrice != nil) ? self.usedBestPrice!.toLocalCurrency() : "-",
                              headline: self.headline ?? "",
                              reviewsAverageNote: self.reviewsAverageNote ?? -1,
                              nbReviews: (self.nbReviews != nil) ? String(self.nbReviews!) : "-",
                              imagesUrls: self.imagesUrls ?? [])
    }
}
