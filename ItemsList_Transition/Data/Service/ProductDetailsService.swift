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
    public func getProductDetail() async throws -> ProductDetailsResponse? {
        let urlString = Constants.getUrlString(of: Constants.requests.productDetails)
        guard let url = URL(string: urlString) else {
            throw AppError.ServiceError.invalidData
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.httpMethod.get
        if #available(iOS 15.0, *) {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = self.getDecoder()
            return try decoder.decode(ProductDetailsResponse.self, from: data)
        } else {
            return try await withCheckedThrowingContinuation({
                (continuation: CheckedContinuation<ProductDetailsResponse?, Error>) in
                getProductDetail(urlRequest: urlRequest, completion: { data, error in
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
    private func getProductDetail(urlRequest: URLRequest, completion: @escaping (ProductDetailsResponse?, Error?) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: urlRequest, completionHandler: {(data, _, error) -> Void in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    let decoder = self.getDecoder()
                    completion(try decoder.decode(ProductDetailsResponse.self, from: data), nil)
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

