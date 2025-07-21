//
//  ContentView.swift
//  Budu
//
//  Created by Afga Ghifari on 15/07/25.
//

import SwiftUI

struct ContentView: View {
        // MARK: - Properties
        private let monthlyBudget: Double = 500000
        private let julyExpenses: Double = 75000
    
        private var availableBalance: Double {
            monthlyBudget - julyExpenses
        }
    
        private var lastMonthDelta: Double {
            monthlyBudget - julyExpenses
        }

        // MARK: - Body
        var body: some View {
            ZStack {
                Color.black
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {
                    availableCardView()
                    
                    budgetCardView()
                    
                    HStack(spacing: 24) {
                        actionsView(title: "Budget", icon: Image(systemName: "plus"), color: .blue)
                        
                        actionsView(title: "Expense", icon: Image(systemName: "minus"), color: .red)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 40)
            }
            .preferredColorScheme(.dark)
        }
    
        @ViewBuilder
        private func availableCardView() -> some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("Available Balance")
                    .font(.headline)
                    .foregroundColor(.secondary)

                Text(formatCurrency(from: availableBalance))
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                
                Divider()
                    .background(Color.white.opacity(0.2))

                Button(action: {
                    print("Navigate to History")
                }) {
                    HStack {
                        Text("View History")
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding()
            .background(
                ZStack {
                    Color.gray.opacity(0.1)
                    LinearGradient(
                        gradient: Gradient(colors:[Color.white.opacity(0.05), Color.blue.opacity(0.1)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                    )
                    .blur(radius: 20)
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .cornerRadius(12)
            .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
            .shadow(color: Color.white.opacity(0.1), radius: 2, x: 0, y: -1)
        }
    
        // MARK: - Private View Builders
        
        @ViewBuilder
        private func budgetInfoView(title: String, amount: Double, color: Color = .white) -> some View {
            HStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(formatCurrency(from: amount))
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(color)
            }
            .padding(.vertical)
        }
    
        @ViewBuilder
        private func budgetCardView() -> some View {
            VStack(spacing: 0) {
                budgetInfoView(title: "Budget", amount: monthlyBudget)
                
                Divider().background(Color.white.opacity(0.2))
                
                budgetInfoView(title: "Expenses", amount: -julyExpenses)
            }
            .padding(.horizontal)
            .background(Color.gray.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(12)
        }
        
    
        @ViewBuilder
        private func actionsView(title: String, icon: Image, color: Color = .white) -> some View {
                Button(action: {}) {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(color)
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(40)
        }

        // MARK: - Helper Methods
        private func formatCurrency(from amount: Double) -> String {
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
}

#Preview {
    ContentView()
}
