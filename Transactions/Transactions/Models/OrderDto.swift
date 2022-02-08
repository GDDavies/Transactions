//
//  OrderDto.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

struct OrderDto {
    let id: String
    let currency: String
    let amount: String
    let orderType: String
    let orderStatus: String
    let createdAt: String
}

extension OrderDto: Decodable {
    enum CodingKeys: String, CodingKey {
         case id = "orderId"
         case currency, amount, orderType, orderStatus, createdAt
     }
}

extension OrderDto {
    func toDomain() -> Order? {
        guard
            let orderType = Order.OrderType(rawValue: orderType),
            let orderStatus = Order.OrderStatus(rawValue: orderStatus),
            let timeInterval = TimeInterval(createdAt)
        else {
            return nil
        }
        return Order(
            id: id,
            currency: currency,
            amount: amount,
            orderType: orderType,
            orderStatus: orderStatus,
            createdAt: Date(timeIntervalSince1970: timeInterval / 1000)
        )
    }
}
