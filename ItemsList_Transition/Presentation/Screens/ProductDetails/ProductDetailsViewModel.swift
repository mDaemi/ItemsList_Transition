//
//  ProductDetailsViewModel.swift
//  ItemsList_Transition
//
//  Created by MDA on 17/07/2023.
//

import Foundation

class ProductDetailsViewModel {
    
    // MARK: - Properties
    private let useCase: PProductDetailsUseCase
    @Published var product: ProductDetailUIModel?
    
    // MARK: - Init
    init(_ useCase: PProductDetailsUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Internal
    public func fetchDetails(for id: Int) async throws {
        let result = try await useCase.loadDetail(for: id).map { $0.toPresentation() }
        product = result
    }
}
