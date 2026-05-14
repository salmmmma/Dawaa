//
//  File.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 11/05/2026.
//

import Foundation
import Combine

protocol HomeAPIProtocol {
    func getBrands() -> AnyPublisher<BrandsComponent, NetworkError>
}
