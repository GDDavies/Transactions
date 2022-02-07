//
//  Fonts.swift
//  Transactions
//
//  Created by George Davies on 07/02/2022.
//

import Foundation
import UIKit

struct Font {
    static func regular(size: CGFloat) -> UIFont {
        UIFont(name: "IBMPlexSans-Regular", size: size)!
    }

    static func semiBold(size: CGFloat) -> UIFont {
        UIFont(name: "IBMPlexSans-SemiBold", size: size)!
    }
}
