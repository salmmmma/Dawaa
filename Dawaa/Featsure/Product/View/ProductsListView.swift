//
//  ProductsListView.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//


import SwiftUI

struct ProductsListView: View {
    
    @StateObject private var vm: ProductsListVM
    
    let productCodes: String
    
    init(productCodes: String) {
        self.productCodes = productCodes
        
        let apiClient = ProductsApiClient()
        let repository = ProductsRepository(apiClient: apiClient)
        self._vm = StateObject(wrappedValue: ProductsListVM(repository: repository))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            content
        }
        .onAppear {
            print("ProductsListView appeared")
            print("productCodes:", productCodes)
            vm.getProducts(productCodes: productCodes)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch vm.uiState {
            
        case .idle:
            loadingView
            
        case .loading:
            loadingView
            
        case .success(let products):
            if products.isEmpty {
                emptyView
            } else {
                productsView(products)
            }
            
        case .empty:
            emptyView
            
        case .failure(let error):
            errorView(error.message)
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 12) {
            ForEach(0..<5, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 115)
                    .padding(.horizontal)
            }
        }
    }
    
    private func productsView(_ products: [ProductModel]) -> some View {
        LazyVStack(spacing: 12) {
            ForEach(products) { product in
                ProductCard(product: product)
            }
        }
    }
    
    private var emptyView: some View {
        Text("No products found")
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.horizontal)
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Failed to load products")
                .font(.caption.bold())
                .foregroundColor(.red)
            
            Text(message)
                .font(.caption)
                .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}
