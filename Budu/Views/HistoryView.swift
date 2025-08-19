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
            .navigationTitle("This Month's History")
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
        .padding(.horizontal, 24)
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
        HStack(spacing: 16) {
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
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
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
