//
//  PProductDetailsRepository.swift
//  ItemsList_Transition
//
//  Created by MDA on 17/07/2023.
//

import Foundation

protocol PProductDetailsRepository {
    func getDetails(for id: Int) async throws -> ProductDetail?
}
