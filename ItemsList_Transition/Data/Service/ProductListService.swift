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
    public func getProducts() async throws -> ProductsResponse? {
        let urlString = Constants.getUrlString(of: Constants.requests.products)
        guard let url = URL(string: urlString) else {
            throw AppError.ServiceError.invalidData
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.httpMethod.get
        if #available(iOS 15.0, *) {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = self.getDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(ProductsResponse.self, from: data)
        } else {
            return try await withCheckedThrowingContinuation({
                (continuation: CheckedContinuation<ProductsResponse?, Error>) in
                getProducts(urlRequest: urlRequest, completion: { data, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: data)
                    }
                })
            })
        }
    }

    // MARK: - Private
    private func getProducts(urlRequest: URLRequest, completion: @escaping (ProductsResponse?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: urlRequest, completionHandler: {(data, _, error) -> Void in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    let decoder = self.getDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    completion(try decoder.decode(ProductsResponse.self, from: data), nil)
                } catch {
                    completion(nil, AppError.ServiceError.invalidData)
                }
            } else {
                completion(nil, AppError.ServiceError.invalidData)
            }
        })
        urlSession.resume()
    }
}
