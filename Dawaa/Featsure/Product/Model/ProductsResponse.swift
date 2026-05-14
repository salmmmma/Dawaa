//
//  ProductsResponse.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//


import Foundation

struct ProductsResponse: Codable {
    let products: [ProductModel]?
    let pagination: ProductsPagination?
}

struct ProductsPagination: Codable {
    let currentPage: Int?
    let pageSize: Int?
    let totalPages: Int?
    let totalResults: Int?

    var hasMore: Bool {
        guard let currentPage, let totalPages else { return false }
        return currentPage + 1 < totalPages
    }
}
