//
//  CartViewModel.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import Foundation
import Combine

final class CartViewModel: ObservableObject {

    struct CellViewModel: Equatable, Identifiable {
        let id: Int
        let imageURL: String
        let title: String
        let price: String
        let count: Int
        let stock: Int

        var isMinusDisabled: Bool { count == 0 }
        var isPlusDisabled: Bool { count >= stock }
    }

    @Published var cells: [CellViewModel] = []

    // TODO: - Improve here with DI
    let cartService: CartServiceProtocol
    var subscriptions = Set<AnyCancellable>()

    init(
        cells: [CellViewModel],
        cartService: CartServiceProtocol = CartService.shared
    ) {
        self.cartService = cartService
        self.cells = cells

        cartService
            .cartProductsPublished
            .sink { products in
                self.cells = products.map({ cartProduct in
                        .init(
                            id: cartProduct.product.id,
                            imageURL: cartProduct.product.thumbnail,
                            title: cartProduct.product.title,
                            // TODO: - Improve with local currency formatter
                            price: "\(cartProduct.product.price) $",
                            count: cartProduct.count,
                            stock: cartProduct.product.stock
                        )
                })
            }
            .store(in: &subscriptions)
    }

    func add(product id: Int) {
        cartService.add(product: id)
    }

    func remove(product id: Int) {
        cartService.remove(product: id)
    }
}
