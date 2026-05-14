//
//  ProductsAPIProtocol.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//


import Combine

protocol ProductsAPIProtocol {
    func getProducts() -> AnyPublisher<ProductsResponse, NetworkError>
}
