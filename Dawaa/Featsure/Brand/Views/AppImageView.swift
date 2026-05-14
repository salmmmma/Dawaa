//
//  AppImageDownloader.swift
//  AlDwaaNewApp
//
//  Created by taha hamdi on 22/05/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct AppImageView: View {
    
    private let fullImageURL: URL?
    private let placeholderImage: Image
    private let isTemplate: Bool
    private let needsOpacity: Bool
    
    @State private var isLoading = true
    
    init(
        baseUrl: String = APIConstants.baseDomain,
        imageUrl: String,
        placeholderImage: Image = Image("placeholder_image"),
        isTemplate: Bool = false,
        needsOpacity: Bool = false
    ) {
        self.fullImageURL = AppImageView.makeURL(baseUrl: baseUrl, imageUrl: imageUrl)
        self.placeholderImage = placeholderImage
        self.isTemplate = isTemplate
        self.needsOpacity = needsOpacity
        self._isLoading = State(initialValue: true)
    }
    
    var body: some View {
        Group {
            if let imageUrl = fullImageURL {
                WebImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .renderingMode(isTemplate ? .template : .original)
                } placeholder: {
                    placeholderContent
                }
                .onSuccess { _, _, _ in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isLoading = false
                    }
                }
                .onFailure { error in
                    print(" AppImageView image failed:", error.localizedDescription)
                    print("image url:", imageUrl.absoluteString)
                    isLoading = false
                }
                .aspectRatio(contentMode: .fit)
                .opacity(needsOpacity ? 0.6 : 1)
                .transition(.fade(duration: 0.2))
            } else {
                placeholderImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(needsOpacity ? 0.6 : 1)
            }
        }
    }
    
    @ViewBuilder
    private var placeholderContent: some View {
        if isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            placeholderImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(needsOpacity ? 0.6 : 1)
        }
    }
    
    private static func makeURL(baseUrl: String, imageUrl: String) -> URL? {
        let trimmed = imageUrl.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else {
            print(" AppImageView empty imageUrl")
            return nil
        }
        
        if trimmed.hasPrefix("http://") || trimmed.hasPrefix("https://") {
            print(" Full image URL:", trimmed)
            return URL(string: trimmed)
        }
        
        let cleanBase = baseUrl.hasSuffix("/") ? String(baseUrl.dropLast()) : baseUrl
        let cleanPath = trimmed.hasPrefix("/") ? trimmed : "/" + trimmed
        let finalURL = cleanBase + cleanPath
        
        print(" Built image URL:", finalURL)
        return URL(string: finalURL)
    }
}
