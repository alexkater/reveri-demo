//
//  ProductService.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 21/2/23.
//

import Foundation

protocol ApiServiceProtocol {
    func fetchProducts(page: Int) async throws -> ProductResponse
}

// TODO: - Move to proper class
enum ApiError: Error {
    case unexpected
    case invalidURL
}

final class ApiService: ApiServiceProtocol {

    func fetchProducts(page: Int) async throws -> ProductResponse {
        guard let url = URL(string: "https://dummyjson.com/products")
        else { throw ApiError.invalidURL }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        // TODO: - Status code comparison should be improved for Product/API needs
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ApiError.unexpected }
        let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
        return productResponse
    }
}
