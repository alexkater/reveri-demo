//
//  ReveriTests.swift
//  ReveriTests
//
//  Created by Alejandro Arjonilla Garcia on 21/2/23.
//

import XCTest
@testable import Reveri

final class ProductTests: XCTestCase {

    func testProductResponseDecode() {
        // Given
        let jsonString = """
        {
            "products": [
                {
                    "id": 1,
                    "title": "iPhone 9",
                    "description": "An apple mobile which is nothing like apple",
                    "price": 549,
                    "discountPercentage": 12.96,
                    "rating": 4.69,
                    "stock": 94,
                    "brand": "Apple",
                    "category": "smartphones",
                    "thumbnail": "...",
                    "images": ["...", "...", "..."]
                }
        ],
            "total": 100,
            "skip": 0,
            "limit": 30
        }
        """
        // When
        let jsonData = Data(jsonString.utf8)
        let productResponse = try! JSONDecoder().decode(ProductResponse.self, from: jsonData)
        // Then

        XCTAssertEqual(productResponse.total, 100)
        XCTAssertEqual(productResponse.skip, 0)
        XCTAssertEqual(productResponse.limit, 30)
        // TODO: - This test should be more explicit to handle all the parameters needed, set simple to build faster, this has been generated with quicktype, so no problems should be there as the json doesn't contains any strange typos
        XCTAssertFalse(productResponse.products.isEmpty)
    }
}
