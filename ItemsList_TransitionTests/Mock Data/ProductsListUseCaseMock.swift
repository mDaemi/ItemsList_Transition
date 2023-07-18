//
//  AppUseCaseMock.swift
//  ItemsList_TransitionTests
//
//  Created by MDA on 18/07/2023.
//

import Foundation
@testable import ItemsList_Transition

class ProductsListUseCaseMock: PProductsListUseCase {
   
    // MARK: - properties
    let repository: PProductListRepository
    
    // MARK: - init
    init(repository: PProductListRepository) {
        self.repository = repository
    }
    
    // MARK: - Internals
    func loadProducts(for keyword: String) async throws -> [Product]? {
        // Test error
        // throw AppError.ServiceError.invalidData
        
        // Test call
        return []
    }
}
