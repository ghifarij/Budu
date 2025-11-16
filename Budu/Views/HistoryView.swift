//
//  HistoryView.swift
//  Budu
//
//  Created by Afga Ghifari on 15/07/25.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var budgetManager: BudgetManager
    @Environment(\.dismiss) private var dismiss
    
    private var sortedExpenses: [Expense] {
        budgetManager.expenses.sorted(by: { $0.date > $1.date })
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                if budgetManager.expenses.isEmpty {
                    emptyHistoryView()
                } else {
                    expensesList()
                }
            }
            .background(Color.black.ignoresSafeArea())
            .preferredColorScheme(.dark)
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    @ViewBuilder
    private func emptyHistoryView() -> some View {
        VStack(spacing: 24) {
            Image(systemName: "list.bullet.clipboard")
                .font(.system(size: 64))
                .foregroundColor(.gray)
            
            Text("No Expenses Yet")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Your expense history will appear here")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func expensesList() -> some View {
        List {
            ForEach(budgetManager.expenses.sorted(by: { $0.date > $1.date })) { expense in
                ExpenseRow(expense: expense)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .onDelete { indexSet in
                let expensesToDelete = indexSet.map { sortedExpenses[$0] }
                
                for expense in expensesToDelete {
                    budgetManager.delete(expense: expense)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

// MARK: - Expense Row

struct ExpenseRow: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(expense.formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(formatCurrency(from: expense.amount))
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.red)
        }
        .padding()
        .background(
            Color.gray.opacity(0.1)
                .cornerRadius(12)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    private func formatCurrency(from amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        formatter.maximumFractionDigits = 0
        
        guard var formattedString = formatter.string(from: NSNumber(value: amount)) else {
            return "Rp0"
        }
        
        formattedString = formattedString.replacingOccurrences(of: " ", with: "")
        return formattedString
    }
}

#Preview {
    // Create a mock BudgetManager with sample data
    let mockManager = BudgetManager()
    
    // Add sample expenses
    let expenses = [
        Expense(
            id: UUID(),
            title: "Batagor",
            amount: 50000,
            date: Date()
        ),
        Expense(
            id: UUID(),
            title: "Nasi Goreng",
            amount: 35000,
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        ),
        Expense(
            id: UUID(),
            title: "Kopi Susu",
            amount: 25000,
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        ),
        Expense(
            id: UUID(),
            title: "Bakso",
            amount: 40000,
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        ),
        Expense(
            id: UUID(),
            title: "Es Teh Manis",
            amount: 15000,
            date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!
        )
    ]
    
    // Add expenses to the mock manager
    for expense in expenses {
        mockManager.expenses.append(expense)
    }
    
    return HistoryView(budgetManager: mockManager)
}

// Alternative: Preview for empty state
#Preview("Empty State") {
    let emptyManager = BudgetManager()
    return HistoryView(budgetManager: emptyManager)
}
