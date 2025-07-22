//
//  Models.swift
//  Budu
//
//  Created by Afga Ghifari on 15/07/25.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id = UUID()
    let title: String
    let amount: Double
    let date: Date
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}

struct MonthlyBudget: Codable {
    var amount: Double
    var month: Int
    var year: Int
    
    var isCurrentMonth: Bool {
        let calendar = Calendar.current
        let now = Date()
        return calendar.component(.month, from: now) == month &&
               calendar.component(.year, from: now) == year
    }
}
