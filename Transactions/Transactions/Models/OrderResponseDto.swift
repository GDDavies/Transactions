//
//  OrderResponseDto.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

struct OrderResponseDto: Decodable {
    let orders: [OrderDto]
}
