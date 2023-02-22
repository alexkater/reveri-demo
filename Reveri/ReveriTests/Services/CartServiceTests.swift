//
//  CartServiceTests.swift
//  ReveriTests
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import XCTest
@testable import Reveri

final class CartServiceTests: XCTestCase {

    func testAddProductOnAnEmptyList() {
        // Given
        let service = CartService()
        let productMock = Product.mock
        // When
        service.add(product: productMock)
        // Then
        XCTAssertEqual(service.cartProducts, [.init(product: productMock, count: 1)])
    }

    func testAddProductOnNonEmptyList() {
        // Given
        let service = CartService()
        let productMock = Product.mock
        // When
        service.add(product: productMock)
        service.add(product: productMock)
        // Then
        XCTAssertEqual(service.cartProducts, [.init(product: productMock, count: 2)])
    }

    func testRemoveProductOnAnEmptyList() {
        // Given
        let service = CartService()
        let productMock = Product.mock
        // When
        service.remove(product: productMock)
        // Then
        XCTAssertEqual(service.cartProducts, [])
    }

    func testRemoveProductWithOneProductAddedAndRemoveFromListDisabled() {
        // Given
        let service = CartService()
        let productMock = Product.mock
        // When
        service.add(product: productMock)
        service.remove(product: productMock.id)
        // Then
        XCTAssertEqual(service.cartProducts, [.init(product: productMock, count: 0)])
    }

    func testRemoveProductWithOneProductAddedAndRemoveFromListEnabled() {
        // Given
        let service = CartService()
        let productMock = Product.mock
        // When
        service.add(product: productMock)
        service.remove(product: productMock)
        // Then
        XCTAssertEqual(service.cartProducts, [])
    }
}

// TODO: - move to proper class
extension Product {

    static var mock: Self {
        .init(
            id: Int.random(in: 0...1000),
            title: "Product title",
            description: "description",
            price: Int.random(in: 1...100),
            discountPercentage: 10,
            rating: 10,
            stock: 3,
            brand: "Brand",
            category: "Category",
            thumbnail: "thumbnail",
            images: []
        )
    }
}
