//
//  CartService.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import Foundation
import Combine

protocol CartServiceProtocol {

    var cartProductsPublished: AnyPublisher<[CartService.CartProduct], Never> { get }

    func add(product: Product)
    func add(product id: Int)
    func remove(product: Product)
    func remove(product id: Int)
}

final class CartService: CartServiceProtocol, ObservableObject {
    // TODO: - Improve and use DI somehow
    static let shared = CartService()

    struct CartProduct: Equatable {
        let product: Product
        var count: Int
    }

    @Published var cartProducts: [CartProduct] = []
    var cartProductsPublished: AnyPublisher<[CartProduct], Never> { $cartProducts.eraseToAnyPublisher() }
    
    func add(product: Product) {
        if let index = cartProducts.firstIndex(where: { $0.product.id == product.id }) {
            guard cartProducts[index].count < product.stock else { return }
            cartProducts[index].count += 1
        } else {
            cartProducts.append(.init(product: product, count: 1))
        }
    }

    func add(product id: Int) {
        if let index = cartProducts.firstIndex(where: { $0.product.id == id }) {
            guard cartProducts[index].count < cartProducts[index].product.stock else { return }
            cartProducts[index].count += 1
        }
    }

    func remove(product: Product) {
        if let index = cartProducts.firstIndex(where: { $0.product.id == product.id }) {
            if cartProducts[index].count > 0 {
                cartProducts[index].count -= 1
                if cartProducts[index].count <= 0 {
                    cartProducts.remove(at: index)
                }
            }
        }
    }

    func remove(product id: Int) {
        if let index = cartProducts.firstIndex(where: { $0.product.id == id }) {
            if cartProducts[index].count > 0 {
                cartProducts[index].count -= 1
            }
        }
    }
}
