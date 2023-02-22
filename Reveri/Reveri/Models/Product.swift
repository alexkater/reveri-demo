//
//  Product.swift
//  Reveri
//
//  Created by Alejandro Arjonilla Garcia on 21/2/23.
//

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable, Equatable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Equatable, Hashable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category, thumbnail: String
    let images: [String]
}
