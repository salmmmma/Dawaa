//
//  ProductsListView.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.


import SwiftUI

struct ProductsListView: View {
    
    @StateObject private var vm: ProductsListVM
    
    init() {
        let apiClient = ProductsApiClient()
        let repository = ProductsRepository(apiClient: apiClient)
        self._vm = StateObject(wrappedValue: ProductsListVM(repository: repository))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            content
        }
        .onAppear {
            vm.getProducts()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch vm.uiState {
            
        case .idle, .loading:
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
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(0..<5, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.15))
                        .frame(width: 170, height: 230)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func productsView(_ products: [ProductModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(products) { product in
                    ProductCard(product: product)
                }
            }
            .padding(.horizontal)
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
