//
//  ProductsListVM.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//


import Foundation
import Combine

final class ProductsListVM: ObservableObject {
    
    @Published private(set) var uiState: UiState<[ProductModel]> = .idle
    @Published var selectedProduct: ProductModel?
    
    private let repository: ProductsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var hasLoaded = false
    
    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProducts(forceReload: Bool = false) {
        
        if hasLoaded && !forceReload {
            return
        }
        
        hasLoaded = true
        uiState = .loading
        
        repository
            .getProducts()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .finished:
                    break
                    
                case .failure(let error):
                    self.uiState = .failure(error)
                }
            } receiveValue: { [weak self] products in
                guard let self else { return }
                
                if products.isEmpty {
                    self.uiState = .empty
                } else {
                    self.uiState = .success(products)
                }
            }
            .store(in: &cancellables)
    }
}
