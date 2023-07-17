//
//  ProductListService.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

final class ProductListService: AbstractService {
    
    // MARK: - Properties
    static let shared = ProductListService()

    // MARK: - public
    public func getProducts(for keyword: String) async throws -> ProductsResponse? {
        let urlString = Constants.getUrlString(of: Constants.requests.products) + keyword
        guard let url = URL(string: urlString) else {
            throw AppError.ServiceError.invalidData
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.httpMethod.get
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = self.getDecoder()
        let result = try decoder.decode(ProductsResponse.self, from: data)
        return result
    }
}
