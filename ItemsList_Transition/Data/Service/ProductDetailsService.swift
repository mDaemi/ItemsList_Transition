//
//  ProductDetailsService.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

import Foundation

final class ProductDetailsService: AbstractService {
    
    // MARK: - Properties
    static let shared = ProductDetailsService()

    // MARK: - public
    public func getProductDetail(for id: Int) async throws -> ProductDetailsResponse? {
        let urlString = Constants.getUrlString(of: Constants.requests.productDetails) + String(id)
        guard let url = URL(string: urlString) else {
            throw AppError.ServiceError.invalidData
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.httpMethod.get
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = self.getDecoder()
        let result = try decoder.decode(ProductDetailsResponse.self, from: data)
        return result
    }
}

