//
//  ProductListDataSpurce.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

class ProductListDataSource {
    // MARK: - Properties
    private let service = ProductListService()

    // MARK: - Public
    public func getProducts() async throws -> [Product]? {
        guard let response = try await service.getProducts()?.products else {
            return []
        }
        
        let result = response.map {$0.toDomain()}
        return result
    }
}
