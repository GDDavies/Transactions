//
//  TransactionsNetworkService.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

protocol TransactionsNetworkServiceProtocol {
    func fetchOrderDtos(completion: @escaping (Result<OrderResponseDto, Error>) -> Void)
}

final class TransactionsNetworkService: TransactionsNetworkServiceProtocol {

    private let networking: NetworkingProcotol
    private let urlRequestBuilder: URLRequestBuilderProtocol

    init(
        networking: NetworkingProcotol,
        urlRequestBuilder: URLRequestBuilderProtocol
    ) {
        self.networking = networking
        self.urlRequestBuilder = urlRequestBuilder
    }

    convenience init() {
        self.init(
            networking: Networking(),
            urlRequestBuilder: URLRequestBuilder(
                baseURL: TransactionsURL.baseURL,
                path: TransactionsURL.Path.orders.rawValue
            )
        )
    }
    
    func fetchOrderDtos(completion: @escaping (Result<OrderResponseDto, Error>) -> Void) {
        let request = urlRequestBuilder.build()
        networking.fetch(request: request, completion: completion)
    }
}
