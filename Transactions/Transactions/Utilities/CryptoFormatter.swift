//
//  CryptoFormatter.swift
//  Transactions
//
//  Created by George Davies on 08/02/2022.
//

import Foundation

final class CryptoFormatter {

    static let shared = CryptoFormatter()

    func convert(value: String, currency: String, orderType: Order.OrderType) -> String? {
        guard
            let number = Decimal(string: value) as NSNumber?
        else {
            return nil
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4

        switch orderType {
        case .buy, .deposit:
            formatter.positivePrefix = formatter.plusSign
        case .sell, .withdraw:
            formatter.positivePrefix = formatter.negativePrefix
        }

        if let formattedString = formatter.string(from: number) {
            return formattedString + " \(currency)"
        } else {
            return nil
        }
    }
}
