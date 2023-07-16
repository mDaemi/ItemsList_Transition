//
//  DataUseCaseProvider.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import Foundation

class DataUseCaseProvider: UseCaseProvider {
    func provideProductsListUseCase() -> PProductsListUseCase {
        return ProductsListUseCase(repository: ProductListRepository.shared)
    }
}
