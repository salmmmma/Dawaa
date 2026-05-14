//
//  File.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 11/05/2026.
//
import Foundation
import Alamofire

enum NetworkError: Error {
    case serverError
    case noInternet
    case decodingError
    case unauthorized
    case notFound
    case timeout
    case unknown
}

extension NetworkError {
    var message: String {
        switch self {
        case .serverError:
            return "Something went wrong. Please try again."
        case .noInternet:
            return "No internet connection."
        case .decodingError:
            return "Failed to read data."
        case .unauthorized:
            return "You are not authorized. Please login again."
        case .notFound:
            return "Requested data was not found."
        case .timeout:
            return "Request timeout. Please try again."
        case .unknown:
            return "Unknown error occurred."
        }
    }
}

extension AFError {
    var toNetworkError: NetworkError {
        if isSessionTaskError {
            let nsError = underlyingError as NSError?
            
            if nsError?.code == NSURLErrorTimedOut {
                return .timeout
            }
            
            if nsError?.code == NSURLErrorNotConnectedToInternet ||
                nsError?.code == NSURLErrorNetworkConnectionLost {
                return .noInternet
            }
            
            return .serverError
        }
        
        if isResponseSerializationError {
            return .decodingError
        }
        
        if let statusCode = responseCode {
            switch statusCode {
            case 401, 403:
                return .unauthorized
            case 404:
                return .notFound
            case 500...599:
                return .serverError
            default:
                return .unknown
            }
        }
        
        return .unknown
    }
}
