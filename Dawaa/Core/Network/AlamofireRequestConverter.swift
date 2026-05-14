//
//  AlamofireRequestConverter.swift
//  NetworkLayer
//
//  Created by Mohammed Hamdi on 04/07/2022.
//

import Foundation
import Alamofire

struct AlamofireRequestConverter: URLRequestConvertible {
    let router: RouterProtocol
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try (router.baseURL + router.path).asURL()
        var request = URLRequest(url: url)
        
        request.method = Alamofire.HTTPMethod(rawValue: router.method.rawValue)
        request.headers = Alamofire.HTTPHeaders(router.headers?.values ?? [:])
        
        let paramsAndEncoding = buildParameters(task: router.task)
        let parameters = paramsAndEncoding.0
        let encoding = paramsAndEncoding.1
        
        request = try encoding.encode(request, with: parameters)
        
        return request
    }
    
    private func buildParameters(task: RouterTask) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestNoParameters:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding.alamofireEncoding())
            
        }
    }
}
