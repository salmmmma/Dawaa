//
//  APIEncoding+Extensions.swift
//  NetworkLayer
//
//  Created by Mohammed Hamdi on 27/06/2022.
//

import Foundation
import Alamofire

extension APIEncoding {
    func alamofireEncoding() -> ParameterEncoding {
        switch self {
        case .URLEncoding(let urlEncodingType):
            switch urlEncodingType {
            case .default:
                return Alamofire.URLEncoding.default
            case .httpBody:
                return Alamofire.URLEncoding.httpBody
            case .queryString:
                return Alamofire.URLEncoding.queryString
            case .custom(destination: let destination, arrayEncoding: let arrayEncoding, boolEncoding: let boolEncoding):
                return Alamofire.URLEncoding(destination: destination.alamofireType(), arrayEncoding: arrayEncoding.alamofireType(), boolEncoding: boolEncoding.alamofireType())
            }
            
        case .JSONEncoding(let jsonEncodingType):
            switch jsonEncodingType {
            case .default:
                return Alamofire.JSONEncoding.default
            case .prettyPrinted:
                return Alamofire.JSONEncoding.prettyPrinted
            case .custom(options: let options):
                return Alamofire.JSONEncoding(options: options)
            }
        }
    }
}

extension APIEncoding.URLEncodingTypes.Destination {
    func alamofireType() -> URLEncoding.Destination {
        switch self {
        case .httpBody:
            return .httpBody
        case .queryString:
            return .queryString
        case .methodDependent:
            return .methodDependent
        }
    }
}

extension APIEncoding.URLEncodingTypes.ArrayEncoding {
    func alamofireType() -> URLEncoding.ArrayEncoding {
        switch self {
        case .brackets:
            return .brackets
        case .indexInBrackets:
            return .indexInBrackets
        case .noBrackets:
            return .noBrackets
        }
    }
}

extension APIEncoding.URLEncodingTypes.BoolEncoding {
    func alamofireType() -> URLEncoding.BoolEncoding {
        switch self {
        case .literal:
            return .literal
        case .numeric:
            return .numeric
        }
    }
}
