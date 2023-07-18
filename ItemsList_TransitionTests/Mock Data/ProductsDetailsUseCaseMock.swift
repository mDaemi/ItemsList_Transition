//
//  ProductsDetailsUseCaseMock.swift
//  ItemsList_TransitionTests
//
//  Created by MDA on 18/07/2023.
//

import Foundation
@testable import ItemsList_Transition

class ProductDetailsUseCaseMock: PProductDetailsUseCase {
  
    // MARK: - properties
    let repository: PProductDetailsRepository
    
    // MARK: - init
    init(repository: PProductDetailsRepository) {
        self.repository = repository
    }
    
    // MARK: - Internals
    func loadDetail(for id: Int) async throws -> ItemsList_Transition.ProductDetail? {
        // Test error
        throw AppError.ServiceError.invalidData
    }
}

