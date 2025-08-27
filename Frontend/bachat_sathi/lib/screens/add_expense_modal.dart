import 'package:flutter/material.dart';

class AddExpenseModal extends StatefulWidget {
  const AddExpenseModal({super.key});

  @override
  State<AddExpenseModal> createState() => _AddExpenseModalState();
}

class _AddExpenseModalState extends State<AddExpenseModal> {
  final TextEditingController _smartInputController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  // Dummy list of categories
  final List<String> _categories = [
    'Food',
    'Bills',
    'Entertainment',
    'Shopping',
    'Transport',
    'Other',
  ];

  @override
  void dispose() {
    _smartInputController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addExpense() {
    // TODO: Implement NLP parsing for the smart input and save the expense.
    // For now, we just print the values and close the modal.
    print('Smart Input: ${_smartInputController.text}');
    print('Amount: ${_amountController.text}');
    print('Description: ${_descriptionController.text}');
    print('Category: $_selectedCategory');

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // This padding adjusts for the on-screen keyboard.
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: keyboardPadding + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Expense',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),

            // Smart Input Field
            TextField(
              controller: _smartInputController,
              decoration: const InputDecoration(
                hintText: 'e.g., "lunch with friends 450"',
                prefixIcon: Icon(Icons.auto_awesome_outlined),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                const Expanded(child: Divider(color: Colors.white24)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('OR', style: theme.textTheme.bodyMedium),
                ),
                const Expanded(child: Divider(color: Colors.white24)),
              ],
            ),
            const SizedBox(height: 24),

            // Manual Fields
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                hintText: 'Amount',
                prefixIcon: Icon(Icons.currency_rupee),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
                prefixIcon: Icon(Icons.edit_outlined),
              ),
            ),
            const SizedBox(height: 16),

            // Category Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: const Text('Select Category'),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.category_outlined),
              ),
              dropdownColor: const Color(0xFF1E1E1E),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              items: _categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Add Expense Button
            ElevatedButton(
              onPressed: _addExpense,
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
