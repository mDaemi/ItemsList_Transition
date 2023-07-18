//
//  ProductListViewModel.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

import Combine

class ProductListViewModel {
    
    // MARK: - Properties
    private let useCase: PProductsListUseCase
    @Published var products: [ProductUIModel] = []
    
    // MARK: - Init
    init(_ useCase: PProductsListUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Internal
    public func fetchProducts(for keyword: String) async throws {
        products = []
        let result = try await useCase.loadProducts(for: keyword).map {$0.map {$0.toPresentation()}} ?? []
        products = result
    }
}

