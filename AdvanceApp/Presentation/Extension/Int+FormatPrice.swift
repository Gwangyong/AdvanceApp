//
//  Int+FormatPrice.swift
//  AdvanceApp
//
//  Created by 서광용 on 8/1/25.
//

import Foundation

extension Int {
  var formatPrice: String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
  }
}
