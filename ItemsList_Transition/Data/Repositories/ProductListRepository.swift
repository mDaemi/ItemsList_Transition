//
//  ProductListRepository.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

class ProductListRepository: PProductListRepository {
    // MARK: - Properties
    static let shared = ProductListRepository()
    private let dataSource: ProductListDataSource = ProductListDataSource()
    
    // MARK: - public
    func getProducts(for keyword: String) async throws -> [Product]? {
        return try await dataSource.getProducts(for: keyword)
    }
}
