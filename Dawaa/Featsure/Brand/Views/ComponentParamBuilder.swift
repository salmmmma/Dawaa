//
//  ComponentParamBuilder.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 11/05/2026.
//

import Foundation

enum ComponentParamBuilder {
    
    static func makeComponentIds(from value: String) -> String {
        let cleaned = value
            .replacingOccurrences(of: "componentIds=", with: "")
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: ",", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        let ids = cleaned
            .split(separator: " ")
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        return ids.joined(separator: ",")
    }
}
