//
//  ProductsApiClient.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//

import Combine

final class ProductsApiClient: APIClient<ProductsRouter>, ProductsAPIProtocol {

    func getProducts() -> AnyPublisher<ProductsResponse, NetworkError> {
        request(
            target: .getProducts,
            responseClass: ProductsResponse.self,
            authenticationType: .noAuth
        )
    }
}
