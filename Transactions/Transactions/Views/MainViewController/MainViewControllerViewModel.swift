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

    var ordersDidUpdate: (() -> Void)?

    let placeholderViewModel = PlaceholderViewModel()
    private let interactor: OrdersInteractorProtocol

    init(interactor: OrdersInteractorProtocol) {
        self.interactor = interactor
        placeholderViewModel.didTapActionButton = { [weak self] in
            self?.didTapDownloadButton()
        }
    }

    convenience init() {
        self.init(interactor: OrdersInteractor())
    }

    func fetchOrders() {
        interactor.fetchOrders { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.ordersDidUpdate?()
                case let .failure(error):
                    // TODO: Error alert
                    print(error)
                }
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
        interactor.getRemoteOrders { [weak self] remoteOrdersResult in
            switch remoteOrdersResult {
            case .success:
                self?.interactor.fetchOrders { localOrdersResult in
                    DispatchQueue.main.async {
                        switch localOrdersResult {
                        case .success:
                            self?.placeholderViewModel.stopActivityIndicator?()
                            self?.ordersDidUpdate?()
                        case let .failure(error):
                            // TODO: Error alert
                            print(error)
                        }
                    }
                }
            case let .failure(error):
                // TODO: Error alert
                print(error)
            }
        }
    }
}
