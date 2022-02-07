//
//  DBOrder.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation
import CoreData

final class DBOrder: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var currency: String
    @NSManaged var amount: String
    @NSManaged var orderType: String
    @NSManaged var orderStatus: String
    @NSManaged var createdAt: String
}

extension DBOrder {
    func toDto() -> OrderDto {
        OrderDto(
            id: id,
            currency: currency,
            amount: amount,
            orderType: orderType,
            orderStatus: orderStatus,
            createdAt: createdAt
        )
    }
}
