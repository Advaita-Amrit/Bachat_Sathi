# -*- coding: utf-8 -*-
"""
A simple command-line personal financial advisor in Python.

This script provides financial advice based on user's profession, income,
and expenses. It's designed to be a foundational model for a more complex
financial management application.
"""

def get_float_input(prompt):
    """
    Safely gets a floating-point number from the user.
    Continues to prompt until a valid number is entered.
    """
    while True:
        try:
            return float(input(prompt))
        except ValueError:
            print("Invalid input. Please enter a number.")

def get_user_profile():
    """
    Asks the user to select their professional profile.
    """
    print("--- Welcome to your Personal Financial Advisor AI ---")
    print("Let's start by understanding your profile.")
    while True:
        profile = input(
            "Enter your profile (student, salaried, businessman, daily_wage): "
        ).lower()
        if profile in ["student", "salaried", "businessman", "daily_wage"]:
            return profile
        else:
            print("Invalid profile. Please choose from the given options.")

def get_financial_data(profile):
    """
    Gathers financial information from the user based on their profile.
    """
    financials = {"profile": profile}
    print("\nPlease provide the following details in your monthly currency (e.g., INR, USD).")

    if profile in ["student", "salaried"]:
        financials["income"] = get_float_input("What is your fixed monthly income/allowance? ")
    else: # Businessman or Daily Wage Earner
        print("\nSince your income can be variable, let's get an idea of your earnings.")
        avg_income = get_float_input("What is your average monthly income? ")
        good_month_income = get_float_input("What is your income in a good month? ")
        bad_month_income = get_float_input("What is your income in a bad month? ")
        financials["income"] = avg_income
        financials["income_variability"] = {
            "good": good_month_income,
            "bad": bad_month_income
        }

    print("\nNow, let's talk about your essential monthly expenses (the must-pays).")
    financials["rent"] = get_float_input("Rent/Mortgage: ")
    financials["utilities"] = get_float_input("Utilities (Electricity, Water, Internet): ")
    financials["groceries"] = get_float_input("Groceries: ")
    financials["transport"] = get_float_input("Transportation: ")
    financials["other_essentials"] = get_float_input("Other essential costs (e.g., cook, household help): ")

    print("\nFinally, let's look at your variable/lifestyle expenses (the nice-to-haves).")
    financials["eating_out"] = get_float_input("Eating out/Entertainment: ")
    financials["shopping"] = get_float_input("Shopping (Clothes, Gadgets, etc.): ")
    financials["other_variable"] = get_float_input("Other personal spending: ")

    return financials

def analyze_finances(data):
    """
    Analyzes the collected financial data and provides a summary and advice.
    """
    # --- 1. Calculate Financial Summary ---
    income = data.get("income", 0)
    essential_expenses = (
        data.get("rent", 0) +
        data.get("utilities", 0) +
        data.get("groceries", 0) +
        data.get("transport", 0) +
        data.get("other_essentials", 0)
    )
    variable_expenses = (
        data.get("eating_out", 0) +
        data.get("shopping", 0) +
        data.get("other_variable", 0)
    )
    total_expenses = essential_expenses + variable_expenses
    surplus_or_deficit = income - total_expenses

    # --- 2. Print Financial Report ---
    print("\n" + "="*40)
    print("        YOUR FINANCIAL ANALYSIS")
    print("="*40)
    print(f"Total Monthly Income:       {income:,.2f}")
    print("-" * 40)
    # Avoid division by zero if income is 0
    if income > 0:
        print(f"Essential Expenses:         {essential_expenses:,.2f} ({essential_expenses/income:.1%})")
        print(f"Variable/Lifestyle Expenses:{variable_expenses:,.2f} ({variable_expenses/income:.1%})")
        print(f"Total Monthly Expenses:     {total_expenses:,.2f} ({total_expenses/income:.1%})")
    else:
        print(f"Essential Expenses:         {essential_expenses:,.2f}")
        print(f"Variable/Lifestyle Expenses:{variable_expenses:,.2f}")
        print(f"Total Monthly Expenses:     {total_expenses:,.2f}")
    print("-" * 40)
    if surplus_or_deficit >= 0:
        print(f"SURPLUS (Money Left Over):  {surplus_or_deficit:,.2f}")
    else:
        print(f"DEFICIT (Shortfall):        {surplus_or_deficit:,.2f}")
    print("="*40 + "\n")


    # --- 3. Generate Personalized Advice ---
    print("💡 Here is your personalized advice:\n")

    # --- Advice for Students ---
    if data["profile"] == "student":
        print("As a student, your primary goal is to build good financial habits.")
        print("1. Track Your Spending: Your biggest variable is 'eating out'. Use a simple app or notebook to see where this money goes. Awareness is the first step.")
        print("2. Set a 'Fun Fund' Limit: Instead of spending freely, decide on a weekly limit for eating out. For example, allocate 1,000-1,500 from your surplus for this. It prevents guilt and overspending.")
        print("3. What to do with Surplus Money:")
        print("   - Emergency Fund First: Before anything else, save at least 3,000-5,000 in a separate savings account. This is your 'uh-oh' fund for unexpected costs, so you don't have to ask for more money.")
        print("   - Small, Regular Savings: Even 500-1,000 a month is great. Open a Recurring Deposit (RD) at a bank. It's a disciplined way to save.")
        print("   - Invest in Yourself: Use some surplus to buy books or take an online course that adds to your skills. This is the best investment you can make right now.")
        print("4. Needing Extra Money: Instead of borrowing, explore part-time jobs, freelance gigs (writing, design, coding), or paid internships related to your field.")

    # --- Advice for Businessmen / Daily Wage Earners ---
    elif data["profile"] in ["businessman", "daily_wage"]:
        print("With variable income, managing cash flow is your superpower.")
        print("1. The 'Two Accounts' Rule: Have two bank accounts. All your earnings go into Account 1. On a fixed date (e.g., the 1st of the month), pay yourself a fixed 'salary' from Account 1 to Account 2. You run your household from Account 2. This creates stability.")
        print("2. Save Aggressively in Good Months: When you have a good month (income > average), transfer at least 50-60% of the extra earnings into a separate savings account *before* you spend it. This fund will cover your expenses during bad months.")
        print("3. Build a Larger Emergency Fund: Aim to have 3-6 months of your *essential expenses* saved up. This is non-negotiable for you. It's the buffer that protects you from debt during lean periods.")
        print("4. Differentiate Business vs. Personal: Keep business expenses completely separate from personal ones. This is crucial for understanding your business's health and for managing your personal finances effectively.")

    # --- General Advice for Everyone ---
    else: # Salaried and as a general rule
        print("1. The 50/30/20 Rule is a great starting point:")
        if income > 0:
            print("   - 50% on Needs (Essentials): Your essential expenses are currently {:.1%}. Try to keep this around 50%.".format(essential_expenses/income))
            print("   - 30% on Wants (Lifestyle): Your variable expenses are {:.1%}. This is the area to cut back if you need to save more.".format(variable_expenses/income))
            print("   - 20% on Savings: You should aim to save at least 20% of your income. Your current surplus is {:.1%}".format(surplus_or_deficit/income if surplus_or_deficit > 0 else 0))
        else:
            print("   - Since your income is zero, we can't calculate percentages. Focus on tracking expenses for now.")
        print("2. Create an Emergency Fund: Aim to save 3-6 months' worth of essential expenses. This is your financial safety net.")
        print("3. Automate Your Savings: On the day you get your salary, set up an automatic transfer to move your savings amount to a separate account. 'Pay yourself first'.")


if __name__ == "__main__":
    # Start the financial advisor by asking for the user's profile
    user_profile = get_user_profile()
    user_data = get_financial_data(user_profile)
    analyze_finances(user_data)
