//
//  HomeBrandVM.swift
//  AlDwaaNewApp
//
//  Created by taha hamdi on 17/05/2023.
//
import Foundation
import Combine

final class HSBrandVM: ObservableObject {
    
    @Published private(set) var uiState: UiState<[ComponentElement]> = .idle
    
    private let repository: BrandsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var hasLoaded = false
    
    init(repository: BrandsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getBrandsData(forceReload: Bool = false) {
        if hasLoaded && !forceReload {
            return
        }
        
        hasLoaded = true
        uiState = .loading
        
        repository
            .getBrands()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .finished:
                    break
                    
                case .failure(let error):
                    self.uiState = .failure(error)
                }
            } receiveValue: { [weak self] brands in
                guard let self else { return }
                
                if brands.isEmpty {
                    self.uiState = .empty
                } else {
                    self.uiState = .success(brands)
                }
            }
            .store(in: &cancellables)
    }
}   
