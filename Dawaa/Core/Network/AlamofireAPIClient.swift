//
//  AlamofireAPIClient.swift
//  NetworkLayer
//
//  Created by Mohammed Hamdi on 27/06/2022.
//

import Foundation
import Alamofire
import Combine
import UIKit

class AlamofireAPIClient<T: RouterProtocol> {
    
    lazy var defaultSessionManager: Session = {
        return createAlamofireSession(interceptor: nil)
    }()
    
//    public func request<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M, NetworkError>) -> Void) {
//        responseDecodableRequest(target: target, responseClass: responseClass) { response in
//            switch response.result {
//            case .success(let decodedObject):
//                completion(.success(decodedObject))
//
//            case .failure(let error):
//                completion(.failure(error.toNetworkError(data: response.data)))
//            }
//        }
//    }
    
    // MARK: Completion Functions
    internal func responseDecodableRequest<M: Decodable>(session: Session, target: T, responseClass: M.Type, completion: @escaping (DataResponse<M, AFError>) -> Void) {
        
        session.request(AlamofireRequestConverter(router: target)).validate().responseDecodable(of: M.self, completionHandler: completion)
    }
    
    internal func responseDecodableRequest<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (DataResponse<M, AFError>) -> Void) {
        
        defaultSessionManager.request(AlamofireRequestConverter(router: target)).validate().responseDecodable(of: M.self, completionHandler: completion)
    }
    
    
//    internal func responseDecodableMultipartRequest<M: Decodable>(session: Session, target: T, responseClass: M.Type, progressCompletion: @escaping (_ percent: Float) -> (), completion: @escaping (DataResponse<M, AFError>) -> Void) {
//
//        session.upload(multipartFormData: { self.setupMultipartParameters(multipartFormData: $0, target: target) }, with: AlamofireRequestConverter(router: target)).validate().uploadProgress { progressCompletion(Float($0.fractionCompleted)) }.responseDecodable(of: M.self, completionHandler: completion)
//    }
    
    // MARK: Combine Functions
//    public func genericCombineRequest<M: Decodable>(target: T, responseClass: M.Type) -> AnyPublisher<M, NetworkError> {
//
//        return publishedDecodableRequest(target: target, responseClass: responseClass).value().mapError { $0.toNetworkError(data: nil) }.eraseToAnyPublisher()
//    }
    
    internal func publishedDecodableRequest<M: Decodable>(session: Session, target: T, responseClass: M.Type) -> DataResponsePublisher<M> {
        
        return session.request(AlamofireRequestConverter(router: target)).validate().publishDecodable(type: M.self, emptyResponseCodes: [200,202,204,201])
    }
    
    internal func publishedDecodableRequest<M: Decodable>(target: T, responseClass: M.Type) -> DataResponsePublisher<M> {
        
        return defaultSessionManager.request(AlamofireRequestConverter(router: target)).validate().publishDecodable(type: M.self, emptyResponseCodes: [200,202,204,201])
    }
    
//    internal func publishedDecodableMultipartRequest<M: Decodable>(session: Session, target: T, responseClass: M.Type, progressCompletion: @escaping (_ percent: Float) -> ()) -> DataResponsePublisher<M> {
//
//        return session.upload(multipartFormData: { self.setupMultipartParameters(multipartFormData: $0, target: target) }, with: AlamofireRequestConverter(router: target)).validate().uploadProgress { progressCompletion(Float($0.fractionCompleted)) }.publishDecodable(type: M.self, emptyResponseCodes: [200,202,204,201])
//    }
}


// MARK: Multipart parameters
//extension AlamofireAPIClient {
//    private func setupMultipartParameters(multipartFormData: MultipartFormData, target: T) {
//        let multipartParameters = target.task.returnMultipartParameters()
//        let bodyParameters = multipartParameters.0
//        let fileItems = multipartParameters.1
//
//        for (key, value) in bodyParameters {
//            multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//        }
//
//        fileItems?.forEach { item in
//            print("📎 Appending file: \(item.fieldName), size: \(item.data.count) bytes, mime: \(item.mimeType)")
//            multipartFormData.append(item.data, withName: item.fieldName, fileName: item.fileName, mimeType: item.mimeType)
//        }
//    }
//}


// MARK: Session Creation
extension AlamofireAPIClient {
    func createAlamofireSession(interceptor: RequestInterceptor? = nil) -> Session {
        // Custom ServerTrustManager that disables SSL validation for specific domains
        let _: [String: ServerTrustEvaluating] = [
            "curaint.al-dawaa.com": DisabledTrustEvaluator() ,// Disable SSL validation for this domain
            "stgapi.dwademo.com":DisabledTrustEvaluator()
        ]
 
//        let trustManager = ServerTrustManager(evaluators: serverTrustPolicies)
        
        // ask taha
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 10 // seconds
        configuration.timeoutIntervalForResource = 20 // seconds
        configuration.waitsForConnectivity = true
        
//        let networkLogger = AlamofireNetworkLogger()
        
        return Session(configuration: configuration,interceptor: interceptor)
        
    }
}
