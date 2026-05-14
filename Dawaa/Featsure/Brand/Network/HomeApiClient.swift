//
//  HomeApiClient.swift
//  AlDwaaNewApp
//
//  Created by taha hamdi on 17/05/2023.
//

import Foundation
import Combine

final class HomeApiClient: APIClient<HomeRouter>, HomeAPIProtocol {
    
    func getBrands() -> AnyPublisher<BrandsComponent, NetworkError> {
        request(
            target: .getBrands,
            responseClass: BrandsComponent.self,
            authenticationType: .noAuth
        )
    }
}
