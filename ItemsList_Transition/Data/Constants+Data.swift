//
//  Constants.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

extension Constants {
    public typealias APIs = Constants.Service.API
    public typealias requests = Constants.Service.API.request
    public typealias httpMethod = Constants.Service.HttpMethod
    
    struct Service {
        struct API {
            static let base = "https://4206121f-64a1-4256-a73d-2ac541b3efe4.mock.pstmn.io/products"
            static let products = "/search?keyword="
            static let productDetails = "/details?id="
            
            enum request {
                case products
                case productDetails
            }
        }
        
        struct HttpMethod {
            static let get = "GET"
            static let put = "PUT"
            static let post = "POST"
            static let delete = "DELETE"
        }
    }
}

extension Constants {
    static func getUrlString(of request: requests) -> String {
        var suffix: String = ""
        
        switch request {
        case .products:
            suffix = APIs.products
        case .productDetails:
            suffix = APIs.productDetails
        }
        
        return "https://\(APIs.base)\(suffix)"
    }
}

