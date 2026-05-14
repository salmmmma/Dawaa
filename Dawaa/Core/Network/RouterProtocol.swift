//
//  RouterProtocol.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//
import Foundation

protocol RouterProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: RouterTask { get }
    var headers: HTTPHeader? { get }
    var currentLang: String { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum RouterTask {
    case requestNoParameters
    case requestParameters(parameters: [String: Any], encoding: APIEncoding)
}

enum HTTPHeader {
    case custom([String: String])
    case `default`
    case empty
    
    var values: [String: String] {
        switch self {
        case .custom(let headers):
            return HTTPHeader.defaultValues.merging(headers) { _, new in new }
            
        case .default:
            return HTTPHeader.defaultValues
            
        case .empty:
            return [:]
        }
    }
    
    private static var defaultValues: [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "deviceType": "IOS"
        ]
    }
}
