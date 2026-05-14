//
//  File.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 11/05/2026.
//
import Foundation

enum UiState<T> {
    case idle
    case loading
    case success(T)
    case empty
    case failure(NetworkError)
}
