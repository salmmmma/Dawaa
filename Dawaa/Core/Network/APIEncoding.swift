//
//  APIEncoding.swift
//  AlDwaaNewApp
//
//  Created by Mohammed Hamdi on 28/09/2022.
//

import Foundation

public enum APIEncoding {
    case URLEncoding(_ type: URLEncodingTypes = .default)
    case JSONEncoding(_ type: JSONEncodingTypes = .default)
    
    public enum URLEncodingTypes {
        case `default`
        case httpBody
        case queryString
        case custom(destination: Destination, arrayEncoding: ArrayEncoding, boolEncoding: BoolEncoding)
        
        public enum Destination {
            case httpBody
            case queryString
            case methodDependent
        }
        
        public enum ArrayEncoding {
            case brackets
            case indexInBrackets
            case noBrackets
        }
        
        public enum BoolEncoding {
            case literal
            case numeric
        }
    }
    
    public enum JSONEncodingTypes {
        case `default`
        case prettyPrinted
        case custom(options: JSONSerialization.WritingOptions)
    }
}
