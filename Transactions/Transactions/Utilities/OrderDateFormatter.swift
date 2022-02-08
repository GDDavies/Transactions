//
//  OrderDateFormatter.swift
//  Transactions
//
//  Created by George Davies on 08/02/2022.
//

import Foundation

final class OrderDateFormatter {

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        return formatter
    }()

    static func convert(date: Date) -> String {
        formatter.string(from: date)
    }
}
