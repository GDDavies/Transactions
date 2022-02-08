//
//  OrdersInteractor.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation
import UIKit

protocol OrdersInteractorProtocol {
    var isDatabaseEmpty: Bool { get }
    func fetchOrders(completion: @escaping () -> Void)
    func numberOfOrders() -> Int
    func order(at row: Int) -> Order?
    func getRemoteOrders(completion: ((Result<Void, Error>) -> Void)?)
}

final class OrdersInteractor: OrdersInteractorProtocol {

    private let repository: OrdersRepositoryProtocol

    var isDatabaseEmpty: Bool {
        repository.numberOfOrders() == 0
    }

    init(repository: OrdersRepositoryProtocol) {
        self.repository = repository
    }

    convenience init() {
        self.init(repository: OrdersRepository())
    }

    func fetchOrders(completion: @escaping () -> Void) {
        if isDatabaseEmpty {
            repository.fetchOrderDtos(completion: completion)
        }
    }

    func numberOfOrders() -> Int {
        repository.numberOfOrders()
    }

    func order(at row: Int) -> Order? {
        repository.order(at: row)?.toDomain()
    }

    func getRemoteOrders(completion: ((Result<Void, Error>) -> Void)?) {
        repository.getRemoteOrders(completion: completion)
    }
}
