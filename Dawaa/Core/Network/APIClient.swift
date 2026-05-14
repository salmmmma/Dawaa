//
//  APIClient.swift
//  NetworkLayer
//
//  Created by Mohammed Hamdi on 24/06/2022.
//

import Foundation
import Alamofire
import Combine

class APIClient<T: RouterProtocol> {
    
    // MARK: Network Client
    /// This client coluld be replaced with a different client that uses a different networking library
    private let networkClient = AlamofireAPIClient<T>()
    
    
    // MARK: Authenticator
   // private lazy var authenticator: AccesssTokenStorage = AppManager.shared.authenticator
    
    
    // MARK: Session Manager
   // private lazy var authedSessionManager: Session = {
    //   let interceptor = AlamofireAuthenticationInterceptor(tokenStorage: authenticator)
        
    //    return networkClient.createAlamofireSession(interceptor: interceptor)
  //  }()
    
    private lazy var defaultSessionManager: Session = {
        return networkClient.defaultSessionManager
    }()
    
//    private func returnSessionManager(authenticationType: ApiAuthenticationType) -> Session {
//        var returnSessionManager: Session;
//        
//        switch authenticationType {
//        case .noAuth:
//            returnSessionManager = defaultSessionManager
//        case .withAuth:
//            returnSessionManager = authedSessionManager
//        case .withAuthIfAvailable:
//            returnSessionManager = authenticator.isLoggedIn ? authedSessionManager : defaultSessionManager
//        }
//        
//      return  returnSessionManager
//        
    //}
    
    // MARK: Completion Based Functions
    
    /// Make a network request, the result is returned in a completion
    ///
    /// ```
    /// request(target: .getAddress, responseClass: Address.self, authenticationType: .auth) { result in
    ///     switch result {
    ///     case .success(let data):
    ///         // Use decoded object
    ///     case .failure(let error):
    ///         // Handle the error
    ///     }
    ///  }
    /// ```
    ///
    /// - Parameters:
    ///   - target: This is the router value which configures the request
    ///   - responseClass: The Model Type which will be decoded
    ///   - authenticationType: Determines if the request will be authenticated with the breaer token or will not be authenticated or authenticat if available; if the user is logged in the request will be authenticated if not it will not be authenticated
    ///   - completion: The completion which will be performed after the request, It passes a Result with the decoded model or Network Error
//    public func request<M: Decodable>(target: T, responseClass: M.Type, authenticationType: ApiAuthenticationType, completion: @escaping (Result<M, NetworkError>) -> Void) {
//        
//        networkClient.responseDecodableRequest(session: returnSessionManager(authenticationType: authenticationType), target: target, responseClass: responseClass) { completion(self.convertResponseWithNetworkError($0))
//        }
//    }
   
    /// Make a multipart request, the progress is retuned in a completion and result is returned in a completion
    ///
    /// ```
    ///  multipartRequest(target: .getAddress, responseClass: Address.self, authenticationType: .auth) { progress in
    ///     // Use the upload progress
    ///  } completion: { result in
    ///     switch result {
    ///     case .success(let data):
    ///         // Use decoded object
    ///     case .failure(let error):
    ///         // Handle the error
    ///     }
    ///  }
    /// ```
    ///
    /// - Parameters:
    ///   - target: This is the router value which configures the request
    ///   - responseClass: The Model Type which will be decoded
    ///   - authenticationType: Determines if the request will be authenticated with the breaer token or will not be authenticated or authenticat if available; if the user is logged in the request will be authenticated if not it will not be authenticated
    ///   - progressCompletion: The progress completion which returns the upload progress percentage
    ///   - completion: The completion which will be performed after the request, It passes a Result with the decoded model or Network Error
//    public func multipartRequest<M: Decodable>(target: T, responseClass: M.Type, authenticationType: ApiAuthenticationType, progressCompletion: @escaping (Float) -> (), completion: @escaping (Result<M, NetworkError>) -> Void) {
//        
//        networkClient.responseDecodableMultipartRequest(session: returnSessionManager(authenticationType: authenticationType), target: target, responseClass: responseClass, progressCompletion: progressCompletion) { completion(self.convertResponseWithNetworkError($0)) }
//    }
    func request<M: Decodable>(
          target: T,
          responseClass: M.Type,
          authenticationType: ApiAuthenticationType = .noAuth
      ) -> AnyPublisher<M, NetworkError> {
          
          return networkClient
              .publishedDecodableRequest(
                  session: defaultSessionManager,
                  target: target,
                  responseClass: responseClass
              )
              .value()
              .mapError { error in
                  error.toNetworkError
              }
              .eraseToAnyPublisher()
      }
//
    
    // MARK: Combine Functions
    
    /// Make a network request, returns a publisher with decoded object
    ///
    /// ```
    /// request(target: .getAddress, responseClass: Address.self, authenticationType: .auth) -> AnyPublisher<Address, NetworkError>
    /// ```
    ///
    /// - Warning: Publishes the object, with error type Network Error
    /// - Parameters:
    ///   - target: This is the router value which configures the request
    ///   - responseClass: The Model Type which will be decoded
    ///   - authenticationType: Determines if the request will be authenticated with the breaer token or will not be authenticated or authenticat if available; if the user is logged in the request will be authenticated if not it will not be authenticated
    /// - Returns: Publisher with the decoded object with a Network Error
//    public func request<M: Decodable>(target: T, responseClass: M.Type, authenticationType: ApiAuthenticationType) -> AnyPublisher<M, NetworkError> {
//        
//        return networkClient.publishedDecodableRequest(session: returnSessionManager(authenticationType: authenticationType), target: target, responseClass: responseClass).map { return self.convertResponseWithNetworkError($0) }.setFailureType(to: NetworkError.self).flatMap(\.publisher).eraseToAnyPublisher()
//    }
    
    /// Make a network request, returns a publisher with a Result type
    ///
    /// ```
    /// request(target: .getAddress, responseClass: Address.self, authenticationType: .auth) -> AnyPublisher<Result<Address, NetworkError>, Never>
    /// ```
    ///
    /// - Warning: Publishes the Result Type, with error type Never
    /// - Parameters:
    ///   - target: This is the router value which configures the request
    ///   - responseClass: The Model Type which will be decoded
    ///   - authenticationType: Determines if the request will be authenticated with the breaer token or will not be authenticated or authenticat if available; if the user is logged in the request will be authenticated if not it will not be authenticated
    /// - Returns: Publisher with a Result type (contains the decoded object or Network Error) and No Error
//    public func request<M: Decodable>(target: T, responseClass: M.Type, authenticationType: ApiAuthenticationType) -> AnyPublisher<Result<M, NetworkError>, Never> {
//        
//        return networkClient.publishedDecodableRequest(session: returnSessionManager(authenticationType: authenticationType), target: target, responseClass: responseClass).map { return self.convertResponseWithNetworkError($0) }.eraseToAnyPublisher()
//    }
    
    /// Make a multipart request, returns a publisher with decoded object
    ///
    /// ```
    /// multipartRequest(target: .getAddress, responseClass: Address.self, authenticationType: .auth) { progress in
    ///     // Use the upload progress
    /// } -> AnyPublisher<Address, NetworkError>
    /// ```
    ///
    /// - Warning: Publishes the object, with error type Network Error
    /// - Parameters:
    ///   - target: This is the router value which configures the request
    ///   - responseClass: This is the router value which configures the request
    ///   - authenticationType: Determines if the request will be authenticated with the breaer token or will not be authenticated or authenticat if available; if the user is logged in the request will be authenticated if not it will not be authenticated
    ///   - progressCompletion: The progress completion which returns the upload progress percentage
    /// - Returns: Publisher with the decoded object with a Network Error
//    public func multipartRequest<M: Decodable>(target: T, responseClass: M.Type, authenticationType: ApiAuthenticationType, progressCompletion: @escaping (Float) -> Void) -> AnyPublisher<M, NetworkError> {
//        
//        return networkClient.publishedDecodableMultipartRequest(session: returnSessionManager(authenticationType: authenticationType), target: target, responseClass: responseClass, progressCompletion: progressCompletion).map { return self.convertResponseWithNetworkError($0) }.setFailureType(to: NetworkError.self).flatMap(\.publisher).eraseToAnyPublisher()
//    }
     
    /// Make a multipart request, returns a publisher with a Result type
    ///
    /// ```
    /// multipartRequest(target: .getAddress, responseClass: Address.self, authenticationType: .auth) { progress in
    ///     // Use the upload progress
    /// } -> AnyPublisher<Result<Address, NetworkError>, Never>
    /// ```
    ///
    /// - Warning: Publishes the Result Type, with error type Never
    /// - Parameters:
    ///   - target: This is the router value which configures the request
    ///   - responseClass: This is the router value which configures the request
    ///   - authenticationType: Determines if the request will be authenticated with the breaer token or will not be authenticated or authenticat if available; if the user is logged in the request will be authenticated if not it will not be authenticated
    ///   - progressCompletion: The progress completion which returns the upload progress percentage
    /// - Returns: Publisher with a Result type (contains the decoded object or Network Error) and No Error
//    public func multipartRequest<M: Decodable>(target: T, responseClass: M.Type, authenticationType: ApiAuthenticationType, progressCompletion: @escaping (Float) -> Void) -> AnyPublisher<Result<M, NetworkError>, Never> {
//        
//        return networkClient.publishedDecodableMultipartRequest(session: returnSessionManager(authenticationType: authenticationType), target: target, responseClass: responseClass, progressCompletion: progressCompletion).map { return self.convertResponseWithNetworkError($0) }.eraseToAnyPublisher()
//    }
    
}

//extension APIClient {
//    
//    private func convertResponseWithNetworkError<M: Decodable>(_ response: DataResponsePublisher<M>.Output) -> Result<M, NetworkError> {
//        switch response.result {
//        case .success(let decodedObject):
//            return .success(decodedObject)
//        case .failure(let error):
//            return .failure(error.toNetworkError(data: response.data))
//        }
//    }
//    

