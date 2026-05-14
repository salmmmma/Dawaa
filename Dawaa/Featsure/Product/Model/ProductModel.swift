//
//  File.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//

import Foundation

struct ProductModel: Codable, Identifiable {
    let code: String?
    let name: String?
    let url: String?
    let urlProductName: String?
    let brand: ProductBrand?
    let price: ProductPrice?
    let simulatedDiscountPrice: ProductPrice?
    let imageUrl: [ProductImageUrl]?
    let inWishlist: Bool?
    let prescription: Bool?
    let addToCartDisabled: Bool?

    // MARK: - Identifiable

    var id: String { code ?? UUID().uuidString }

    // MARK: - Computed

    var displayImageUrl: String {
        imageUrl?.first(where: { $0.key == "en" })?.value
            ?? imageUrl?.first(where: { $0.key == "ar" })?.value
            ?? imageUrl?.first?.value
            ?? ""
    }

    var displayPrice: String { price?.formattedValue ?? "" }

    var displayDiscountPrice: String { simulatedDiscountPrice?.formattedValue ?? "" }

    var brandName: String { brand?.name ?? "" }
}

// MARK: - Supporting Models

struct ProductImageUrl: Codable {
    let key: String?
    let value: String?
}

struct ProductBrand: Codable {
    let code: String?
    let name: String?
}

struct ProductPrice: Codable {
    let currencyIso: String?
    let formattedValue: String?
    let priceType: String?
    let value: Double?
}
