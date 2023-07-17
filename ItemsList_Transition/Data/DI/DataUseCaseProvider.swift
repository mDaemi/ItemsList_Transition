//
//  DataUseCaseProvider.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import Foundation

class DataUseCaseProvider: UseCaseProvider {
    func provideProductDetailsUseCase() -> PProductDetailsUseCase {
        return ProductDetailsUseCase(repository: ProductDetailsRepository.shared)
    }
    
    func provideProductsListUseCase() -> PProductsListUseCase {
        return ProductsListUseCase(repository: ProductListRepository.shared)
    }
}
