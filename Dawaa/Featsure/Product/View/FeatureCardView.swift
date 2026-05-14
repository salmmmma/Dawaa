//
//  FeatureCardView.swift
//  Dawaa
//

import SwiftUI
import Combine

struct FeatureCardView<T: CardSliderProtocol>: View {

    // MARK: - Properties

    let sliderItems: [T]
    let indicatorTintColor: Color
    let onItemSelected: (T) -> Void

    // MARK: - State

    @State private var selectedIndex: Int = 0
    @State private var isReversed: Bool = false

    // MARK: - Constants

    private let cardWidth: CGFloat = 170
    private let cardHeight: CGFloat = 230
    private let autoScrollInterval: TimeInterval = 3.0

    private let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .bottom) {
            if sliderItems.isEmpty {
                emptyView
            } else {
                sliderView
                indicatorsView
                    .padding(.bottom, 12)
            }
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.12), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
        .onReceive(timer) { _ in advanceSlide() }
    }

    // MARK: - Subviews

    private var sliderView: some View {
        TabView(selection: $selectedIndex) {
            ForEach(sliderItems.indices, id: \.self) { index in
                bannerImage(for: sliderItems[index])
                    .onTapGesture { onItemSelected(sliderItems[index]) }
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    private func bannerImage(for item: T) -> some View {
        ZStack {
            Color.white
            if let url = item.imageURL, !url.isEmpty {
                AppImageView(imageUrl: url)
                    .frame(width: cardWidth, height: cardHeight)
                    .clipped()
            } else {
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .cornerRadius(16)
    }

    private var indicatorsView: some View {
        HStack(spacing: 5) {
            ForEach(sliderItems.indices, id: \.self) { index in
                Circle()
                    .fill(index == selectedIndex ? indicatorTintColor : Color.gray.opacity(0.5))
                    .frame(width: 7, height: 7)
            }
        }
    }

    private var emptyView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.gray.opacity(0.12))
            .overlay(
                Text("No banners")
                    .font(.caption)
                    .foregroundColor(.gray)
            )
    }

    // MARK: - Auto-scroll Logic

    private func advanceSlide() {
        guard sliderItems.count > 1 else { return }
        withAnimation(.easeInOut(duration: 0.5)) {
            if isReversed {
                if selectedIndex == 0 {
                    isReversed = false
                    selectedIndex += 1
                } else {
                    selectedIndex -= 1
                }
            } else {
                if selectedIndex == sliderItems.count - 1 {
                    isReversed = true
                    selectedIndex -= 1
                } else {
                    selectedIndex += 1
                }
            }
        }
    }
}
