//
//  OrdersRepository.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

protocol OrdersRepositoryProtocol {
    // listen for new orders
    func fetchOrderDtos(completion: @escaping () -> Void)
    func numberOfOrders() -> Int
    func order(at row: Int) -> OrderDto?
    func getRemoteOrders(completion: ((Result<Void, Error>) -> Void)?)
}

final class OrdersRepository: OrdersRepositoryProtocol {

    private let databaseService: TransactionsDatabaseServiceProtocol
    private let networkService: TransactionsNetworkServiceProtocol

    init(
        databaseService: TransactionsDatabaseServiceProtocol,
        networkService: TransactionsNetworkServiceProtocol
    ) {
        self.databaseService = databaseService
        self.networkService = networkService
    }

    convenience init() {
        self.init(
            databaseService: TransactionsDatabaseService(),
            networkService: TransactionsNetworkService()
        )
    }

    func fetchOrderDtos(completion: @escaping () -> Void) {
        databaseService.fetchOrderDtos(completion: completion)
    }

    func numberOfOrders() -> Int {
        databaseService.numberOfOrders()
    }

    func order(at row: Int) -> OrderDto? {
        databaseService.order(at: row)?.toDto()
    }

    func getRemoteOrders(completion: ((Result<Void, Error>) -> Void)?) {
        networkService.fetchOrderDtos { [weak self] result in
            switch result {
            case let .success(response):
                self?.databaseService.save(
                    orderDtos: response.orders,
                    completion: completion
                )
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
}
