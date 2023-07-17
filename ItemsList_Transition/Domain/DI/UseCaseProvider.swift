//
//  UseCaseProvider.swift
//  ItemsList_Transition
//
//  Created by MDA on 15/07/2023.
//

import UIKit

protocol UseCaseProvider {
    func provideProductsListUseCase() -> PProductsListUseCase
    func provideProductDetailsUseCase() -> PProductDetailsUseCase
}
