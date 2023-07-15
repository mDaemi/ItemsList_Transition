//
//  AppError.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

enum AppError: Error {

    public enum ServiceError {
        /// unknown problem occurred while calling the url
        case unknown(url: URL?)
        /// url returns no data and no error
        case noDataFound(in: URL?)
        case statusError(statusCode: Int, message: String)
        case error(error: Error?)
        case other(message: String)
        case invalidData
    }
    
    public enum FunctionalError {
        case general(message: String)
    }
}


extension AppError.ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .unknown(url: url):
            let urlString = url != nil ? url!.absoluteString : ""
            return "URL is not valid: \(urlString)"
        case let .noDataFound(in: url):
            let urlString = url != nil ? url!.absoluteString : ""
            return "No returned data from URL \(urlString)"
        case let .statusError(statusCode: _, message: message):
            return message
        case let .error(error: error):
            return error?.localizedDescription
        case let .other(message: message):
            return message
        case .invalidData:
            return "Return of invalid data"
        }
    }
}

extension AppError.FunctionalError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .general(message: message):
            return message
        }
    }
}


