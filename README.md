# Budu - Personal Budget Tracker

A simple and elegant iOS budget tracking app built with SwiftUI. Track your monthly budget, expenses, and stay on top of your finances with an intuitive interface.

## Features

### 💰 Budget Management
- Set and update your monthly budget
- View available balance at a glance
- Real-time budget tracking

### 📊 Expense Tracking
- Add expenses with title and amount
- Automatic date tracking
- Quick expense entry with number pad
- View total expenses

### 📜 History & Reports
- Complete expense history with dates
- Swipe to delete expenses
- Sorted by most recent
- Indonesian Rupiah (IDR) currency formatting

### 🎨 User Interface
- Clean, modern design with system colors
- Dark mode support
- Smooth animations and transitions
- Empty state illustrations
- Gradient card designs with subtle shadows

### 🔄 Data Management
- Local data persistence using UserDefaults
- Reset all data option
- JSON-based data encoding/decoding

## Technical Details

### Architecture
- **SwiftUI** for declarative UI
- **MVVM Pattern** with ObservableObject
- **UserDefaults** for local data persistence
- **Combine Framework** for reactive programming

### Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

### Project Structure

```
Budu/
├── BuduApp.swift           # App entry point
├── Models/
│   └── Models.swift        # Data models (Expense, MonthlyBudget)
├── ViewModels/
│   └── BudgetManager.swift # Business logic and data management
├── Views/
│   ├── ContentView.swift   # Main dashboard
│   ├── BudgetFormView.swift    # Budget input form
│   ├── ExpenseFormView.swift   # Expense input form
│   └── HistoryView.swift       # Expense history list
├── Utilities/
│   ├── ButtonStyles.swift      # Custom UI styles
│   └── FormatCurrency.swift    # Currency formatting helper
└── Assets.xcassets/        # App assets and icons
```

## Installation

1. Clone the repository
```bash
git clone https://github.com/ghifarij/Budu
```

2. Open the project in Xcode
```bash
cd Budu
open Budu.xcodeproj
```

3. Build and run on your device or simulator
- Select your target device
- Press `Cmd + R` to build and run

## Usage

### Setting Your Budget
1. Tap the "Budget" button on the main screen
2. Enter your monthly budget amount
3. Tap "Save" to set your budget

### Adding Expenses
1. Tap the "Expense" button on the main screen
2. Enter the expense title (e.g., "Lunch", "Gas")
3. Enter the amount
4. Tap "Add" to save the expense

### Viewing History
1. Tap "View History" on the available balance card
2. Swipe left on any expense to delete
3. View all expenses sorted by date

### Resetting Data
1. Tap the "Reset" button in the navigation bar
2. Confirm the action to clear all data

## Data Models

### Expense
```swift
struct Expense: Identifiable, Codable {
    var id: UUID
    let title: String
    let amount: Double
    let date: Date
}
```

### MonthlyBudget
```swift
struct MonthlyBudget: Codable {
    var amount: Double
    var month: Int
    var year: Int
}
```

## Currency Formatting

The app uses Indonesian Rupiah (IDR) formatting:
- Locale: `id_ID`
- No decimal places
- Format: `Rp50.000` (for 50,000)
- Negative amounts: `- Rp50.000`

## Customization

### Changing Currency
To change the currency locale, modify `FormatCurrency.swift`:
```swift
formatter.locale = Locale(identifier: "en_US") // For USD
formatter.locale = Locale(identifier: "ja_JP") // For JPY
```

### Styling
Custom styles are defined in `ButtonStyles.swift`:
- `CustomTextFieldStyle` - Rounded text field with background

### Colors
The app uses semantic system colors that automatically adapt to light/dark mode:
- `.primary` - Main text
- `.secondary` - Secondary text
- `.secondarySystemBackground` - Card backgrounds
- `.separator` - Border colors

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available for personal and educational use.

## Author

Created by Afga Ghifari

## Acknowledgments

- App icon created with AI assistance
- Built with SwiftUI and passion 🔥

---

**Budu** - Simple budget tracking for everyday life 🎯
