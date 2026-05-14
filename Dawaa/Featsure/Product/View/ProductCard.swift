//
//  ProductCard.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//

import SwiftUI

struct ProductCard: View {

    // MARK: - Properties

    let product: ProductModel

    // MARK: - Constants

    private let cardWidth: CGFloat = 170
    private let cardHeight: CGFloat = 230
    private let imageHeight: CGFloat = 105

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageView
            brandLabel
            nameLabel
            priceView
            Spacer(minLength: 0)
        }
        .padding(12)
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.12), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
    }

    // MARK: - Subviews

    private var imageView: some View {
        ZStack {
            Color.white
            if product.displayImageUrl.isEmpty {
                Image(systemName: "photo")
                    .font(.title2)
                    .foregroundColor(.gray.opacity(0.5))
            } else {
                AppImageView(imageUrl: product.displayImageUrl)
                    .padding(8)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: imageHeight)
        .cornerRadius(12)
    }

    @ViewBuilder
    private var brandLabel: some View {
        if !product.brandName.isEmpty {
            Text(product.brandName)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
        }
    }

    private var nameLabel: some View {
        Text(product.name ?? "Product")
            .font(.subheadline.bold())
            .foregroundColor(.black)
            .lineLimit(2)
            .frame(height: 42, alignment: .top)
    }

    @ViewBuilder
    private var priceView: some View {
        let displayValue = product.displayDiscountPrice.isEmpty
            ? product.displayPrice
            : product.displayDiscountPrice

        if !displayValue.isEmpty {
            Text(displayValue)
                .font(.subheadline.bold())
                .foregroundColor(.green)
                .lineLimit(1)
        }
    }
}
