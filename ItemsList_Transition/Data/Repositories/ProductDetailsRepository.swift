//
//  ProductDetailsRepository.swift
//  ItemsList_Transition
//
//  Created by MDA on 17/07/2023.
//

import Foundation

class ProductDetailsRepository: PProductDetailsRepository {
   
    // MARK: - Properties
    static let shared = ProductDetailsRepository()
    private let dataSource: ProductDetailsDataSource = ProductDetailsDataSource()
    
    // MARK: - public
    func getDetails(for id: Int) async throws -> ProductDetail? {
        return try await dataSource.getProductDetails(for: id)
    }
}
