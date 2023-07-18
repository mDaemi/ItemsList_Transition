//
//  ProductDetailsUseCase.swift
//  ItemsList_Transition
//
//  Created by MDA on 17/07/2023.
//

import Foundation

protocol PProductDetailsUseCase {
    func loadDetail(for id: Int) async throws -> ProductDetail?
}

class ProductDetailsUseCase: PProductDetailsUseCase {
    // MARK: - properties -
    let repository: PProductDetailsRepository
    
    // MARK: - init -
    init(repository: PProductDetailsRepository) {
        self.repository = repository
    }
    
    // MARK: - Internals -
    func loadDetail(for id: Int) async throws -> ProductDetail? {
        return try await self.repository.getDetails(for: id)
    }
}

