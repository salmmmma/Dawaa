//
//  ProductsRepositoryProtocol.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//
import Combine

protocol ProductsRepositoryProtocol {
    func getProducts() -> AnyPublisher<[ProductModel], NetworkError>
}
