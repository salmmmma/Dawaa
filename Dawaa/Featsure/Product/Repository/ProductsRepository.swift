//
//  ProductsRepository.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//

import Combine

import Combine

final class ProductsRepository: ProductsRepositoryProtocol {

    // MARK: - Private

    private let apiClient: ProductsAPIProtocol

    // MARK: - Init

    init(apiClient: ProductsAPIProtocol) {
        self.apiClient = apiClient
    }

    // MARK: - ProductsRepositoryProtocol

    func getProducts() -> AnyPublisher<[ProductModel], NetworkError> {
        apiClient
            .getProducts()
            .map { $0.products ?? [] }
            .eraseToAnyPublisher()
    }
}
