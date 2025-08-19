//
//  BudgetManager.swift
//  Budu
//
//  Created by Afga Ghifari on 15/07/25.
//

import Foundation

@MainActor
class BudgetManager: ObservableObject {
    @Published var currentBudget: MonthlyBudget?
    @Published var expenses: [Expense] = []
    
    private let budgetKey = "monthly_budget"
    private let expensesKey = "expenses"
    
    init() {
        loadData()
        checkAndResetForNewMonth()
    }
    
    var availableBalance: Double {
        guard let budget = currentBudget else { return 0 }
        return budget.amount - totalExpenses
    }
    
    var totalExpenses: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    func setBudget(_ amount: Double) {
        let calendar = Calendar.current
        let now = Date()
        let month = calendar.component(.month, from: now)
        let year = calendar.component(.year, from: now)
        
        currentBudget = MonthlyBudget(amount: amount, month: month, year: year)
        saveBudget()
    }
    
    func addExpense(title: String, amount: Double) {
        let expense = Expense(title: title, amount: amount, date: Date())
        expenses.append(expense)
        saveExpenses()
    }
    
    func delete(expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses.remove(at: index)
            saveExpenses()
        }
    }
    
    // MARK: - Private Methods
    private func loadData() {
        loadBudget()
        loadExpenses()
    }
    
    private func loadBudget() {
        if let data = UserDefaults.standard.data(forKey: budgetKey),
           let budget = try? JSONDecoder().decode(MonthlyBudget.self, from: data) {
            currentBudget = budget
        }
    }
    
    private func loadExpenses() {
        if let data = UserDefaults.standard.data(forKey: expensesKey),
           let loadedExpenses = try? JSONDecoder().decode([Expense].self, from: data) {
            expenses = loadedExpenses
        }
    }
    
    private func saveBudget() {
        if let budget = currentBudget,
           let data = try? JSONEncoder().encode(budget) {
            UserDefaults.standard.set(data, forKey: budgetKey)
        }
    }
    
    private func saveExpenses() {
        if let data = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(data, forKey: expensesKey)
        }
    }
    
    private func checkAndResetForNewMonth() {
        guard let budget = currentBudget else { return }
        
        if !budget.isCurrentMonth {
            // Reset for new month
            currentBudget = nil
            expenses = []
            
            // Clear stored data
            UserDefaults.standard.removeObject(forKey: budgetKey)
            UserDefaults.standard.removeObject(forKey: expensesKey)
        }
    }
}
