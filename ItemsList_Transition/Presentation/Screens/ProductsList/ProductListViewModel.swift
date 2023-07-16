//
//  ProductListViewModel.swift
//  ItemsList_Transition
//
//  Created by MDA on 16/07/2023.
//

//import UIKit
//
//
//
//class CardViewModel {
//    var viewMode: CardViewMode = .card
//    var title: String? = nil
//    var backgroundImage: UIImage? = nil
//    var backgroundType: BackgroundType = .light
//
//    init(bgImage: UIImage, bgType: BackgroundType?, title: String, subtitle: String, description: String, app: AppViewModel) {
//        self.backgroundImage = bgImage.imageWith(newSize: CGSize(width: 375, height: 450))
//        self.title = title
//        self.backgroundType = bgType ?? .light
//    }
//}

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
        let result = try await useCase.loadProducts(for: keyword).map {$0.map {$0.toPresentation()}} ?? []
        products = result
    }
}

