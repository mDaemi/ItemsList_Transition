//
//  PProductListRepository.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import Foundation

protocol PProductListRepository {
    func getProducts() async throws -> [Product]?
}
