//
//  HomeBrandView.swift
//  AlDwaaNewApp
//
//  Created by taha hamdi on 17/05/2023.
//

import SwiftUI

struct HSBrandCard: View {
    
    let brand: ComponentElement
    
    var body: some View {
        AppImageView(imageUrl: imageUrl)
            .scaledToFit()
            .frame(width: 140, height: 70)
            .background(Color.white)
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
            )
    }
    
    private var imageUrl: String {
        brand.component?.media?.mobile?.url ??
        brand.component?.media?.desktop?.url ??
        brand.component?.media?.widescreen?.url ??
        brand.component?.media?.url ??
        ""
    }
}
