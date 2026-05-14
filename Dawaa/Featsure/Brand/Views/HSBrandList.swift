//
//  HomeBrandList.swift
//  AlDwaaNewApp
//
//  Created by taha hamdi on 23/08/2023.
//
import SwiftUI

struct HSBrandList: View {
    
    @Binding var selectedBrand: ComponentElement?
    @ObservedObject var vm: HSBrandVM
    
    let pageName: String
    let brandsKey: String
    let onBrandTap: ((ComponentElement) -> Void)?
    
    init(
        selectedBrand: Binding<ComponentElement?>,
        vm: HSBrandVM,
        pageName: String = "none",
        brandsKey: String,
        onBrandTap: ((ComponentElement) -> Void)? = nil
    ) {
        self._selectedBrand = selectedBrand
        self.vm = vm
        self.pageName = pageName
        self.brandsKey = brandsKey
        self.onBrandTap = onBrandTap
    }
    
    var body: some View {
        content
    }
    
    @ViewBuilder
    private var content: some View {
        switch vm.uiState {
            
        case .idle:
            EmptyView()
            
        case .loading:
            loadingView
            
        case .success(let brands):
            if brands.isEmpty {
                emptyView
            } else {
                brandsView(brands)
            }
            
        case .empty:
            emptyView
            
        case .failure(let error):
            errorView(error.message)
        }
    }
    
    private var loadingView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(0..<5, id: \.self) { _ in
                    HSBrandCardShimmer()
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 80)
    }
    
    private func brandsView(_ brands: [ComponentElement]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(brands, id: \.id) { brand in
                    HSBrandCard(brand: brand)
                        .onTapGesture {
                            selectedBrand = brand
                            onBrandTap?(brand)
                        }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 90)
    }
    
    private var emptyView: some View {
        Text("No brands found")
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.horizontal)
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Failed to load brands")
                .font(.caption.bold())
                .foregroundColor(.red)
            
            Text(message)
                .font(.caption)
                .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}
