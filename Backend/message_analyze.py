import re

def process_transaction_message(message):
    """
    Analyzes a single SMS message to extract transaction details.
    Returns a dictionary with the details, or None if it's not a transaction.
    """
    message = message.lower()
    
    # --- Step 1: Filter for relevant keywords and ignore OTPs ---
    transaction_keywords = ['debited', 'credited', 'spent', 'rs.', 'inr', 'txn']
    otp_keywords = ['otp', 'one time password', 'verification']
    
    if not any(keyword in message for keyword in transaction_keywords):
        return None # Not a transaction message
        
    if any(keyword in message for keyword in otp_keywords):
        return None # It's an OTP, ignore it

    # --- Step 2: Extract details using Regular Expressions ---
    details = {
        'amount': None,
        'merchant': 'Unknown',
        'type': 'expense' # Default to expense
    }

    # Extract Amount (looks for Rs. or INR followed by numbers)
    amount_match = re.search(r'(?:rs\.?|inr)\s*([\d,]+\.?\d*)', message)
    if amount_match:
        # Remove commas and convert to float
        details['amount'] = float(amount_match.group(1).replace(',', ''))

    # Determine Transaction Type
    if 'credited' in message:
        details['type'] = 'income'

    # Extract Merchant (looks for text after 'at', 'on', or 'to')
    merchant_match = re.search(r'\s(at|on|to)\s+([a-z0-9\s.-]+)', message)
    if merchant_match:
        # The merchant name is the second group, strip any extra whitespace or trailing dots
        details['merchant'] = merchant_match.group(2).strip().split('.')[0]

    # Only return a result if an amount was successfully found
    if details['amount']:
        return details
    
    return None



if __name__ == "__main__":

    # --- Example Usage ---
    sms1 = "Rs. 450.00 debited from your A/c for a purchase at Zomato."
    sms2 = "Your OTP for login is 123456. Do not share it."
    sms3 = "You have received Rs. 5000 credited to your account from YourCompany."
    sms4 = "Alert: A transaction of INR 250 was made on your card at Starbucks."

    # sms1= input("Enter SMS 1: ")
    # sms2= input("Enter SMS 2: ")
    # sms3= input("Enter SMS 3: ")
    # sms4= input("Enter SMS 4: ")

    print(f"'{sms1}' -> {process_transaction_message(sms1)}")
    print(f"'{sms2}' -> {process_transaction_message(sms2)}")
    print(f"'{sms3}' -> {process_transaction_message(sms3)}")
    print(f"'{sms4}' -> {process_transaction_message(sms4)}")