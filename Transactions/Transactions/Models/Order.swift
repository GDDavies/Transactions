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
    }
    
    enum OrderStatus: String {
        case executed
        case canceled
        case approved
        case processing
    }
}
