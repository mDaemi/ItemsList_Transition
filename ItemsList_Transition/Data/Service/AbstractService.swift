//
//  AbstractService.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

class AbstractService {
    // MARK: - Properties
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    // MARK: - Internal
    func getDecoder() -> JSONDecoder {
        return decoder
    }
}
