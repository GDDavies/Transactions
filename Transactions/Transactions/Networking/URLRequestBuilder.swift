//
//  URLRequestBuilder.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

protocol URLRequestBuilderProtocol {
    func build() -> URLRequest
}

class URLRequestBuilder: URLRequestBuilderProtocol {
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    let baseURL: URL
    let path: String
    let method: HTTPMethod
    
    init(
        baseURL: URL,
        path: String,
        method: HTTPMethod = .get
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
    }

    func build() -> URLRequest {
        var urlRequest = URLRequest(
            url: baseURL.appendingPathComponent(path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
