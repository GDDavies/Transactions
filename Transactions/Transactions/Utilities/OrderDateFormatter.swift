//
//  OrderDateFormatter.swift
//  Transactions
//
//  Created by George Davies on 08/02/2022.
//

import Foundation

final class OrderDateFormatter {

    static let shared = OrderDateFormatter()

    func convert(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        return formatter.string(from: date)
    }
}
