//
//  MainViewControllerViewModel.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

final class MainViewControllerViewModel {

    var hidePlaceholder: Bool {
        !interactor.isDatabaseEmpty
    }

    private let interactor: OrdersInteractorProtocol

    var ordersDidUpdate: (() -> Void)?

    init(interactor: OrdersInteractorProtocol) {
        self.interactor = interactor
    }

    convenience init() {
        self.init(interactor: OrdersInteractor())
    }

    func fetchOrders() {
        interactor.fetchOrders { [weak self] in
            DispatchQueue.main.async {
                self?.ordersDidUpdate?()
            }
        }
    }

    func numberOfOrders() -> Int {
        interactor.numberOfOrders()
    }

    func orderCellViewModel(at row: Int) -> OrderCellViewModel? {
        guard let order = interactor.order(at: row) else { return nil }
        return OrderCellViewModel(order: order)
    }

    func didTapDownloadButton() {
        interactor.getRemoteOrders { [weak self] result in
            switch result {
            case .success:
                self?.interactor.fetchOrders {
                    DispatchQueue.main.async {
                        self?.ordersDidUpdate?()
                    }
                }
            case let .failure(error):
                print(error) // TODO: Error alert
            }
        }
    }
}
