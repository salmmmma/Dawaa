//
//  HSBrandCardShimmer.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 11/05/2026.
//

import Foundation
import SwiftUI

struct HSBrandCardShimmer: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(Color.gray.opacity(0.25))
            .frame(width: 140, height: 55)
            .shimmer()
    }
}
