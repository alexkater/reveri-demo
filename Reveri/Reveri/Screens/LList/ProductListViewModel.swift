// 
//  ProductListViewModel.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import Combine
import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {

    struct CellViewModel: Equatable, Identifiable {
        let id: Int
        let imageURL: String
        let title: String
        let description: String
        let price: String
    }

    enum State: Equatable {
        case loaded([CellViewModel])
        case loading
        case error
    }

    @Published var state = State.loading
    @Published var maxReached = false

    // TODO: - Same here, use DI somehow
    var cartService: CartServiceProtocol = CartService.shared
    var apiService: ApiServiceProtocol = ApiService()
    private var products: Set<Product> = []
    private var currentPage: Int = 0

    init(state: State = State.loading) {
        self.state = state
    }

    func fetchMore() {
        Task {
            do {
                let productsResponse = try await apiService.fetchProducts(page: currentPage)
                currentPage += productsResponse.limit
                maxReached = currentPage == productsResponse.total
                products = products.union(productsResponse.products)
                DispatchQueue.main.async {
                    self.state = .loaded(self.products.map { product in
                        CellViewModel(
                            id: product.id,
                            imageURL: product.thumbnail,
                            title: product.title,
                            description: product.description,
                            // TODO: - Use local currency formatter
                            price: "\(product.price) $"
                        )
                    })
                }
            } catch {
                state = .error
            }
        }
    }

    func add(product id: Int) {
        if let product = products.first(where: { id == $0.id }) {
            cartService.add(product: product)
        }
    }
}
