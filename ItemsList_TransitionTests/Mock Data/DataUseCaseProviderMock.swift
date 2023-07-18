//
//  DataUseCaseProviderMock.swift
//  ItemsList_TransitionTests
//
//  Created by MDA on 18/07/2023.
//

import Foundation
@testable import ItemsList_Transition

class DataUseCaseProviderMock: UseCaseProvider {
    func provideProductsListUseCase() -> PProductsListUseCase {
        return ProductsListUseCaseMock(repository: ProductListRepository.shared)
    }
    
    func provideProductDetailsUseCase() -> PProductDetailsUseCase {
        return ProductDetailsUseCaseMock(repository: ProductDetailsRepository.shared)
    }
}
