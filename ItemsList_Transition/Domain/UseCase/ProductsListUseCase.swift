//
//  AppUseCase.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

protocol PProductsListUseCase {
    func loadProducts(for keyword: String) async throws -> [Product]?
}

class ProductsListUseCase: PProductsListUseCase {
    // MARK: - properties
    let repository: PProductListRepository
    
    // MARK: - init
    init(repository: PProductListRepository) {
        self.repository = repository
    }
    
    // MARK: - Internals
    func loadProducts(for keyword: String) async throws -> [Product]? {
        return try await self.repository.getProducts(for: keyword)
    }
}

