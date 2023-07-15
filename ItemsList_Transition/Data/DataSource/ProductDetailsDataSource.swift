//
//  ProductDetailDataSource.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

class ProductDetailsDataSource {
    // MARK: - Properties
    private let service = ProductDetailsService()

    // MARK: - Public
    public func getProductDetails() async throws -> ProductDetail? {
        let result = try await service.getProductDetail()?.toDomain()
        return result
    }
}
