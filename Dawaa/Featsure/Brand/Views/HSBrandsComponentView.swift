//
//  BrandsComponentView.swift
//  AlDwaaNewApp
//
//  Created by taha hamdi on 23/08/2023.
//
import SwiftUI

struct HSBrandsComponentView: View {
    
    @StateObject private var vm: HSBrandVM
    
    let title: String
    
    init(title: String) {
        self.title = title
        
        let apiClient = HomeApiClient()
        let repository = BrandsRepository(apiClient: apiClient)
        self._vm = StateObject(wrappedValue: HSBrandVM(repository: repository))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.horizontal)
            
            content
        }
        .onAppear {
            vm.getBrandsData()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch vm.uiState {
            
        case .idle, .loading:
            loadingView
            
        case .success(let brands):
            brandsView(brands)
            
        case .empty:
            Text("No brands found")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
        case .failure(let error):
            VStack(alignment: .leading, spacing: 8) {
                Text("Failed to load brands")
                    .font(.caption.bold())
                    .foregroundColor(.red)
                
                Text(error.message)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            .padding(.horizontal)
        }
    }
    
    private var loadingView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(0..<5, id: \.self) { _ in
                    HSBrandCardShimmer()
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 90)
    }
    
    private func brandsView(_ brands: [ComponentElement]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(brands) { brand in
                    HSBrandCard(brand: brand)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 90)
    }
}
