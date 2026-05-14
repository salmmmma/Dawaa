//
//  ProductsRouter.swift
//  Dawaa
//
//  Created by Mohammed Hassanien on 12/05/2026.
//




import Foundation

enum ProductsRouter {
    case getProducts
}

// MARK: - RouterProtocol

extension ProductsRouter: RouterProtocol {

    var currentLang: String { "en" }

    var baseURL: String { APIConstants.baseDomain }

    var path: String {
        switch self {
        case .getProducts:
            return "occ/v2/aldawaa/products/multi/search"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }

    var task: RouterTask {
        switch self {
        case .getProducts:
            return .requestParameters(
                parameters: [
                    "fields": "FULL",
                    "query": ProductCodesBuilder.build(
                        from: """
                        103442,202274,203005,205795,207860,208750,208886,211127,
                        217166,220627,229046,231218,232309,232702,239854,241427,
                        241598,243728,243734,243959,244030,244492,245461,509234
                        """
                    ),
                    "pageSize": 20,
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
