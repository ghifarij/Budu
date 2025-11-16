//
//  ContentView.swift
//  Budu
//
//  Created by Afga Ghifari on 15/07/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var budgetManager = BudgetManager()
    @State private var showingBudgetForm = false
    @State private var showingExpenseForm = false
    @State private var showingHistory = false
    @State private var showingResetAlert = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {
                    availableCardView()
                    
                    budgetCardView()
                    
                    HStack(spacing: 24) {
                        actionsView(title: "Budget", icon: Image(systemName: "plus"), color: .blue) {
                            showingBudgetForm = true
                        }
                        
                        actionsView(title: "Expense", icon: Image(systemName: "minus"), color: .red) {
                            showingExpenseForm = true
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 40)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        showingResetAlert = true
                    }
                    .tint(.red)
                    .accessibilityLabel("Reset all data")
                }
            }
            .alert("Reset All Data?", isPresented: $showingResetAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    budgetManager.resetAll()
                }
            } message: {
                Text("This clears your budget, expenses, and history.")
            }
            .sheet(isPresented: $showingBudgetForm) {
                BudgetFormView(budgetManager: budgetManager)
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showingExpenseForm) {
                ExpenseFormView(budgetManager: budgetManager)
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showingHistory) {
                HistoryView(budgetManager: budgetManager)
                .presentationDragIndicator(.visible)
            }
        }
    }

    // MARK: - View Builders
    @ViewBuilder
    private func availableCardView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Available Balance")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(formatCurrency(from: budgetManager.availableBalance))
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Divider()
                .background(Color(uiColor: .separator))

            Button(action: {
                showingHistory = true
            }) {
                HStack {
                    Text("View History")
                        .font(.body)
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.blue)
            }
        }
        .padding()
        .background(
            ZStack {
                Color(uiColor: .secondarySystemBackground)
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.05)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(uiColor: .separator), lineWidth: 1)
        )
        .cornerRadius(12)
        .shadow(color: Color.blue.opacity(0.2), radius: 8, x: 0, y: 4)
    }
        
    @ViewBuilder
    private func budgetInfoView(title: String, amount: Double, color: Color? = nil) -> some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Text(formatCurrency(from: amount))
                .font(.title3)
                .fontWeight(.regular)
                .foregroundStyle(color ?? .primary)
        }
        .padding(.vertical)
    }

    @ViewBuilder
    private func budgetCardView() -> some View {
        VStack(spacing: 0) {
            budgetInfoView(title: "Budget",
                           amount: budgetManager.currentBudget?.amount ?? 0)
            
            Divider()
                .background(Color(uiColor: .separator))
            
            budgetInfoView(title: "Expenses",
                           amount: budgetManager.totalExpenses,
                           color: .red)
        }
        .padding(.horizontal)
        .background(Color(uiColor: .secondarySystemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(uiColor: .separator), lineWidth: 1)
        )
        .cornerRadius(12)
    }
        
    @ViewBuilder
    private func actionsView(title: String, icon: Image, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(color)
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .secondarySystemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color(uiColor: .separator), lineWidth: 1)
        )
        .cornerRadius(40)
    }
}

#Preview {
    ContentView()
}
