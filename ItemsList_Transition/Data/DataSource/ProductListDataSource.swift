//
//  ProductListDataSpurce.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

class ProductListDataSource {
    // MARK: - Properties -
    private let service = ProductListService()

    // MARK: - Public -
    public func getProducts(for keyword: String) async throws -> [Product]? {
        guard let response = try await service.getProducts(for: keyword)?.products else {
            return []
        }
        
        let result = response.compactMap {$0.toDomain()}
        return result
    }
}
