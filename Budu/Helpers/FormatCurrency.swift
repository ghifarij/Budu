//
//  FormatCurrency.swift
//  Budu
//
//  Created by Afga Ghifari on 16/11/25.
//

import SwiftUI

// MARK: - Helper Methods
func formatCurrency(from amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "id_ID")
    formatter.maximumFractionDigits = 0
    
    let isNegative = amount < 0
    let absoluteAmount = abs(amount)
    
    guard var formattedString = formatter.string(from: NSNumber(value: absoluteAmount)) else {
        return "Rp0"
    }

    formattedString = formattedString.replacingOccurrences(of: " ", with: "")
    
    return isNegative ? "- " + formattedString : formattedString
}
