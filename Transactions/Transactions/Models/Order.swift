//
//  Order.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

struct Order {
    let id: String
    let currency: String
    let amount: String
    let orderType: OrderType
    let orderStatus: OrderStatus
    let createdAt: Date
}

extension Order {
    enum OrderType: String {
        case deposit
        case withdraw
        case buy
        case sell

        var orderPrefix: String? {
            switch self {
            case .deposit:
                return NSLocalizedString("In", comment: "")
            case .withdraw:
                return NSLocalizedString("Out", comment: "")
            case .buy, .sell:
                return nil
            }
        }
    }
    
    enum OrderStatus: String {
        case executed
        case canceled
        case approved
        case processing
    }
}
