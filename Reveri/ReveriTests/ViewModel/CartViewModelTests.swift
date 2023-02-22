//
//  CartViewModelTests.swift
//  ReveriTests
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import XCTest
@testable import Reveri

final class CartViewModelTests: XCTestCase {

    func testOnInitSyncProducts() {
        // Given
        let cartServiceMock = CartServiceMock()
        cartServiceMock.cartProductsPublished = Just([CartService.CartProduct.init(product: .mock, count: 1)])
            .eraseToAnyPublisher()
        let viewModel = CartViewModel(cells: [], cartService: cartServiceMock)
        // Then
        XCTAssertFalse(viewModel.cells.isEmpty)
    }

    func testAdd() {
        // Given
        let cartServiceMock = CartServiceMock()
        let productMock = Product.mock
        cartServiceMock.cartProductsPublished = Just([CartService.CartProduct.init(product: productMock, count: 1)])
            .eraseToAnyPublisher()
        let viewModel = CartViewModel(cells: [], cartService: cartServiceMock)
        // When
        viewModel.add(product: productMock.id)
        // Then
        XCTAssertEqual(cartServiceMock.addProductCalled, 1)
    }

    func testRemove() {
        // Given
        let cartServiceMock = CartServiceMock()
        let productMock = Product.mock
        cartServiceMock.cartProductsPublished = Just([CartService.CartProduct.init(product: productMock, count: 1)])
            .eraseToAnyPublisher()
        let viewModel = CartViewModel(cells: [], cartService: cartServiceMock)
        // When
        viewModel.remove(product: productMock.id)
        // Then
        XCTAssertEqual(cartServiceMock.removeProductCalled, 1)
    }
}

import Combine

final class CartServiceMock: CartServiceProtocol {

    var addProductCalled = 0
    var removeProductCalled = 0

    var cartProductsPublished: AnyPublisher<[Reveri.CartService.CartProduct], Never> = Empty().eraseToAnyPublisher()

    func add(product: Reveri.Product) {
        addProductCalled += 1
    }

    func add(product id: Int) {
        addProductCalled += 1
    }

    func remove(product: Reveri.Product) {
        removeProductCalled += 1
    }

    func remove(product id: Int) {
        removeProductCalled += 1
    }
}
