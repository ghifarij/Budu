//
//  BudgetFormView.swift
//  Budu
//
//  Created by Afga Ghifari on 15/07/25.
//

import SwiftUI

struct BudgetFormView: View {
    @ObservedObject var budgetManager: BudgetManager
    @Environment(\.dismiss) private var dismiss
    @State private var budgetText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Budget")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Text("Set your budget")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Amount")
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    TextField("Enter amount", text: $budgetText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(CustomTextFieldStyle())
                        .focused($isTextFieldFocused)
                }
                
                Spacer()
            }
            .padding(24)
            .background(Color(uiColor: .systemBackground).ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let amount = Double(budgetText), amount > 0 {
                            budgetManager.setBudget(amount)
                            dismiss()
                        }
                    }
                    .disabled(budgetText.isEmpty || Double(budgetText) == nil || Double(budgetText) ?? 0 <= 0)
                }
            }
            .onAppear {
                if let budget = budgetManager.currentBudget {
                    budgetText = String(format: "%.0f", budget.amount)
                }
                isTextFieldFocused = true
            }
        }
    }
}
