//
//  ExpenseFormView.swift
//  Budu
//
//  Created by Afga Ghifari on 15/07/25.
//

import SwiftUI

struct ExpenseFormView: View {
    @ObservedObject var budgetManager: BudgetManager
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var amountText = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case title, amount
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Add Expense")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Track your spending")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Title")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        TextField("e.g., Lunch, Gas, Coffee", text: $title)
                            .textFieldStyle(CustomTextFieldStyle())
                            .focused($focusedField, equals: .title)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Amount")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        TextField("Enter amount", text: $amountText)
                            .keyboardType(.numberPad)
                            .textFieldStyle(CustomTextFieldStyle())
                            .focused($focusedField, equals: .amount)
                    }
                }
                
                Spacer()
                
                Button("Add Expense") {
                    if let amount = Double(amountText), amount > 0, !title.isEmpty {
                        budgetManager.addExpense(title: title, amount: amount)
                        dismiss()
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(title.isEmpty || amountText.isEmpty || Double(amountText) == nil || Double(amountText) ?? 0 <= 0)
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
                focusedField = .title
            }
        }
    }
}
