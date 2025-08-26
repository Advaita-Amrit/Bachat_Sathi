# -*- coding: utf-8 -*-
"""
A Python backend script to analyze an expense log, categorize spending,
and provide budgetary advice based on user input.
"""
import pandas as pd
from io import StringIO
import sys

def get_user_profile():
    """
    Asks the user to select their professional profile.
    """
    print("--- Welcome to your Personal Expense Analyzer ---")
    print("Let's start by understanding your profile.")
    while True:
        profile = input(
            "Enter your profile (student, salaried, businessman, daily_wage): "
        ).lower()
        if profile in ["student", "salaried", "businessman", "daily_wage"]:
            return profile
        else:
            print("Invalid profile. Please choose from the given options.")

def get_expense_log_input():
    """
    Prompts the user to enter their multiline expense data.
    """
    print("\n--- Enter Your Expense Log ---")
    print("Paste your expense data below. The format should be: Date,Description,Amount")
    print("Enter 'done' on a new line when you are finished.")
    
    lines = []
    # Add the header for the CSV data
    lines.append("Date,Description,Amount")
    
    while True:
        try:
            line = input()
            if line.lower() == 'done':
                break
            lines.append(line)
        except EOFError:
            # This handles the case where input is piped into the script
            break
            
    return "\n".join(lines)

def analyze_expenses(expense_data_string, monthly_income, profile):
    """
    Analyzes a string of expense data, categorizes it, and provides a report.

    Args:
        expense_data_string (str): A multiline string representing CSV data
                                   with 'Date', 'Description', and 'Amount' columns.
        monthly_income (float): The user's total monthly income.
        profile (str): The user's professional profile.
    """

    # --- 1. Define Categories and Budget ---
    # Keywords are used to automatically categorize expenses.
    # The budget is a recommended percentage of total spending for each category.
    categories = {
        "Housing & Bills": {
            "keywords": ["rent", "bill", "electricity", "internet", "water", "phone", "gas"],
            "budget_percent": 35
        },
        "Food": {
            "keywords": ["cook", "grocery", "food", "restaurant", "swiggy", "zomato", "meal", "coffee", "snacks"],
            "budget_percent": 20
        },
        "Transportation": {
            "keywords": ["travel", "uber", "ola", "taxi", "bus", "train", "fuel", "petrol"],
            "budget_percent": 10
        },
        "Entertainment": {
            "keywords": ["movie", "concert", "tickets", "netflix", "spotify", "hobby", "fun"],
            "budget_percent": 10
        },
        "Personal Care & Shopping": {
            "keywords": ["shopping", "clothes", "salon", "gym", "health", "pharmacy"],
            "budget_percent": 10
        },
        "Savings & Goals": {
            "keywords": ["saving", "investment", "sip", "goal", "deposit"],
            "budget_percent": 15 # This is a target for savings from income
        },
        "Miscellaneous": {
            "keywords": [], # Catches anything not in other categories
            "budget_percent": 0 # Should ideally be low
        }
    }

    # --- 2. Load and Categorize Data ---
    try:
        # Use StringIO to read the string data into a pandas DataFrame
        data = StringIO(expense_data_string)
        df = pd.read_csv(data)

        # Ensure 'Amount' is a numeric type
        df['Amount'] = pd.to_numeric(df['Amount'], errors='coerce')
        df.dropna(subset=['Amount'], inplace=True)

        if df.empty:
            print("\nNo valid expense data was entered. Exiting analysis.")
            return

    except Exception as e:
        print(f"Error reading data: {e}")
        print("Please make sure your data is in the format: Date,Description,Amount")
        return

    def categorize_expense(description):
        """Assigns a category based on keywords in the description."""
        description = str(description).lower()
        for category, details in categories.items():
            for keyword in details["keywords"]:
                if keyword in description:
                    return category
        return "Miscellaneous"

    df['Category'] = df['Description'].apply(categorize_expense)

    # --- 3. Perform Analysis ---
    total_expenses = df['Amount'].sum()
    category_spending = df.groupby('Category')['Amount'].sum().to_dict()

    # Ensure all categories are present in the spending dictionary
    for category in categories:
        if category not in category_spending:
            category_spending[category] = 0

    # --- 4. Print Financial Report ---
    print("\n" + "="*50)
    print("        MONTHLY EXPENSE ANALYSIS")
    print("="*50)
    print(f"User Profile: {profile.capitalize()}")
    print(f"Total Monthly Income: {monthly_income:,.2f}")
    print(f"Total Monthly Expenses: {total_expenses:,.2f}")
    
    surplus = monthly_income - total_expenses
    if surplus >= 0:
        print(f"SURPLUS (Money Left for Savings): {surplus:,.2f}")
    else:
        print(f"DEFICIT (Overspent): {surplus:,.2f}")
    print("="*50)

    print("\n--- Spending by Category ---\n")
    print(f"{'Category':<25} | {'Amount Spent':>15} | {'% of Expenses':>15}")
    print("-" * 60)
    for category, amount in sorted(category_spending.items(), key=lambda item: item[1], reverse=True):
        percentage = (amount / total_expenses * 100) if total_expenses > 0 else 0
        print(f"{category:<25} | {amount:>15,.2f} | {percentage:>14.1f}%")

    # --- 5. Generate Budget Advice and Warnings ---
    print("\n" + "="*50)
    print("        BUDGETARY ADVICE & WARNINGS")
    print("="*50)

    overall_overuse = False
    if total_expenses > monthly_income:
        print("🚨 GENERAL ALERT: You are spending more than you earn! This is a major red flag.")
        overall_overuse = True

    print("\n--- Category Breakdown ---\n")
    wrong_patterns = []
    for category, details in categories.items():
        if category == "Savings & Goals": continue # Skip savings for this check

        actual_percent = (category_spending.get(category, 0) / total_expenses * 100) if total_expenses > 0 else 0
        budget_percent = details["budget_percent"]

        if actual_percent > budget_percent:
            message = (f"❗ OVERUSE FUNDS: You spent {actual_percent:.1f}% on '{category}', "
                       f"which is higher than the recommended {budget_percent}%.")
            wrong_patterns.append(message)
            print(message)

    if not wrong_patterns and total_expenses > 0:
        print("✅ Great job! Your spending within individual categories is well-managed.")

    print("\n--- Final Recommendations ---\n")
    if overall_overuse:
        print("1. Immediate Action: Review the 'OVERUSE FUNDS' categories above. These are the first places to cut back.")
    elif surplus < (monthly_income * 0.15): # If saving less than 15%
        print(f"1. Boost Your Savings: Your spending is under control, but your savings are low. As a {profile}, aim to save at least 15% of your income. Look for small cuts in 'Entertainment' or 'Shopping' to increase your surplus.")
    else:
        print("1. Excellent Financial Health: You are living within your means and saving a good portion of your income. Keep up the great work!")

    print("2. Review 'Miscellaneous': If you have a high percentage in 'Miscellaneous', it means many expenses aren't being tracked properly. Try to be more descriptive in your log.")


if __name__ == "__main__":
    # --- Get User Details and Expense Log ---
    user_profile = get_user_profile()
    
    while True:
        try:
            print("\n--- Expense Analyzer ---")
            my_income = float(input("\nWhat is your total monthly income? "))
            break
        except ValueError:
            print("Invalid input. Please enter a number for your income.")

    expense_log = get_expense_log_input()

    # --- Run the Analysis ---
    analyze_expenses(expense_log, my_income, user_profile)
