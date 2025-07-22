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
                    Text("Monthly Budget")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Set your budget for this month")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Amount")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    TextField("Enter amount", text: $budgetText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(CustomTextFieldStyle())
                        .focused($isTextFieldFocused)
                }
                
                Spacer()
                
                Button("Set Budget") {
                    if let amount = Double(budgetText), amount > 0 {
                        budgetManager.setBudget(amount)
                        dismiss()
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(budgetText.isEmpty || Double(budgetText) == nil || Double(budgetText) ?? 0 <= 0)
            }
            .padding(24)
            .background(Color.black.ignoresSafeArea())
            .preferredColorScheme(.dark)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
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
