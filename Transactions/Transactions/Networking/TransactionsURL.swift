//
//  TransactionsURL.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation

struct TransactionsURL {
    
    static let baseURL = URL(string: "https://assessments.stage.copper.co")!
    
    enum Path: String {
        case orders = "/ios/orders"
    }
    
}
