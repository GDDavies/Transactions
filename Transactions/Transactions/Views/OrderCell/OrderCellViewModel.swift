//
//  OrderCellViewModel.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

struct OrderCellViewModel {
    let title: String
    let subtitle: String
    let detailTitle: String
    let detailSubtitle: String

    init(order: Order) {
        if let prefix = order.orderType.orderPrefix {
            title = prefix + " " + order.currency
        } else {
            if case .buy = order.orderType {
                title = "BTC → " + order.currency
            } else if case .sell = order.orderType {
                title = order.currency + " → BTC"
            } else {
                title = order.currency
            }
        }
        subtitle = OrderDateFormatter.convert(
            date: order.createdAt
        )
        detailTitle = CryptoFormatter.convert(
            value: order.amount,
            currency: order.currency,
            orderType: order.orderType
        ) ?? ""
        detailSubtitle = order.orderStatus.rawValue.capitalized
    }
}
