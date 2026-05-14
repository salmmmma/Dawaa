//
//  File.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 11/05/2026.
//
import Foundation
import Combine

final class BrandsRepository: BrandsRepositoryProtocol {
    
    private let apiClient: HomeAPIProtocol
    
    init(apiClient: HomeAPIProtocol) {
        self.apiClient = apiClient
    }
    
    func getBrands() -> AnyPublisher<[ComponentElement], NetworkError> {
        apiClient
            .getBrands()
            .map { response in
                (response.components ?? []).filter { $0.status == "SUCCESS" }
            }
            .eraseToAnyPublisher()
    }
}
