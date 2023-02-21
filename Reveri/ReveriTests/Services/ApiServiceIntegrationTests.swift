//
//  ApiServiceIntegrationTests.swift
//  ReveriTests
//
//  Created by Alejandro Arjonilla Garcia on 22/2/23.
//

import XCTest

@testable import Reveri

final class ApiServiceIntegrationTests: XCTestCase {

    func testFetchProducts() async throws {
        // Given
        let service: ApiServiceProtocol = ApiService()
        // When
        let productResponse = try await service.fetchProducts(page: 0)
        // Then
        XCTAssertNotNil(productResponse)
    }
}
