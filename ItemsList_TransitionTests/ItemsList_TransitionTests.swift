//
//  ItemsList_TransitionTests.swift
//  ItemsList_TransitionTests
//
//  Created by MDA on 15/07/2023.
//

import XCTest
@testable import ItemsList_Transition

final class ItemsList_TransitionTests: XCTestCase {

    // MARK: - Properties
    var listViewModel: ProductListViewModel?
    var detailViewModel: ProductDetailsViewModel?
    
    override func setUpWithError() throws {
        listViewModel = ProductListViewModel( DataUseCaseProviderMock().provideProductsListUseCase())
        detailViewModel = ProductDetailsViewModel( DataUseCaseProviderMock().provideProductDetailsUseCase())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListViewModel_GetProducts() {
        Task {
            do {
                try await listViewModel?.fetchProducts(for: "samsung")
                XCTAssertTrue(listViewModel?.products.count == 20)
            } catch {
                XCTFail()
            }
        }
    }
    
    func testDetailViewModel_GetDetail() {
        Task {
            do {
                try await detailViewModel?.fetchDetails(for: 1)
                XCTAssertTrue(detailViewModel?.product != nil)
            } catch {
                XCTFail()
            }
        }
    }
}
