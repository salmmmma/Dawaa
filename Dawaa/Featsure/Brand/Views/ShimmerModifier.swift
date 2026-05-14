//
//  ShimmerModifier.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 11/05/2026.
//

import Foundation
import SwiftUI

struct ShimmerModifier: ViewModifier {
    
    @State private var move = false
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    LinearGradient(
                        colors: [
                            .clear,
                            .white.opacity(0.65),
                            .clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geometry.size.width * 1.5)
                    .offset(x: move ? geometry.size.width : -geometry.size.width * 1.5)
                }
            }
            .clipped()
            .onAppear {
                withAnimation(
                    .linear(duration: 1.1)
                    .repeatForever(autoreverses: false)
                ) {
                    move = true
                }
            }
    }
}

extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}
