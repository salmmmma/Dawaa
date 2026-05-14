//
//  ProductCodesBuilder.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//


import Foundation

enum ProductCodesBuilder {

    static func build(from value: String) -> String {
        value
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: ",", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: " ")
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: ",")
    }
}
