//
//  PlaceholderViewModel.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation
import UIKit

struct PlaceholderViewModel {
    let image = UIImage(named: "placeholder")
    let title = NSLocalizedString("Transactions", comment: "")
    let subtitle = NSLocalizedString("Click \"Download\" to view transaction history", comment: "")
    let buttonTitle = NSLocalizedString("Download", comment: "")
}
