//
//  HomeRouter.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//


import Foundation

enum HomeRouter {
    case getBrands
}

extension HomeRouter: RouterProtocol {
    
    var currentLang: String {
        "en"
    }
    
    var baseURL: String {
        APIConstants.baseDomain
    }
    
    var path: String {
        switch self {
        case .getBrands:
            return "occ/v2/aldawaa/cms/components/ids"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBrands:
            return .get
        }
    }
    
    var task: RouterTask {
        switch self {
        case .getBrands:
            return .requestParameters(
                parameters: [
                    "componentIds": "cmsitem_00083000,cmsitem_00083002,cmsitem_00083001,cmsitem_00083003,cmsitem_00083005",
                    "fields": "FULL",
                    "lang": currentLang
                ],
                encoding: .URLEncoding(.queryString)
            )
        }
    }
    
    var headers: HTTPHeader? {
        .default
    }
}
