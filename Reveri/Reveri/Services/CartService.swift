//
//  CartService.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import Foundation

protocol CartServiceProtocol {

    func add(product: Product)
    func remove(product: Product, removeFromList: Bool)
}

final class CartService: CartServiceProtocol {
    // TODO: - Improve and use DI somehow
    static let shared = CartService()

    struct CartProduct: Equatable {
        let product: Product
        var count: Int
    }

    var cartProducts: [CartProduct] = []

    func add(product: Product) {
        if let index = cartProducts.firstIndex(where: { $0.product.id == product.id }) {
            cartProducts[index].count += 1
        } else {
            cartProducts.append(.init(product: product, count: 1))
        }
    }

    func remove(product: Product, removeFromList: Bool) {
        // TODO: - This logic maybe could be improved, keep it simple for now
        if let index = cartProducts.firstIndex(where: { $0.product.id == product.id }) {
            if cartProducts[index].count > 0 {
                cartProducts[index].count -= 1
                if cartProducts[index].count <= 0 && removeFromList {
                    cartProducts.remove(at: index)
                }
            }
        }
    }
}
