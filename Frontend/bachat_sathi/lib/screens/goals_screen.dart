import 'package:flutter/material.dart';

// A model for a single savings goal
class SavingsGoal {
  final String name;
  final double targetAmount;
  final double savedAmount;

  SavingsGoal({
    required this.name,
    required this.targetAmount,
    required this.savedAmount,
  });
}

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  // Dummy list of savings goals
  final List<SavingsGoal> _goals = [
    SavingsGoal(name: 'Trip to Goa', targetAmount: 25000, savedAmount: 8000),
    SavingsGoal(name: 'New Laptop', targetAmount: 80000, savedAmount: 45000),
    SavingsGoal(
      name: 'Emergency Fund',
      targetAmount: 100000,
      savedAmount: 95000,
    ),
  ];

  void _showAddGoalDialog() {
    // TODO: Create a dedicated screen or a more complex modal for adding a goal
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Add New Goal'),
          content: const Text(
            'This will open a form to name the goal, set the target amount, and choose a target date.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals & Savings'),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _showAddGoalDialog,
            tooltip: 'Add Goal',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          return GoalCard(goal: goal);
        },
      ),
    );
  }
}

// A reusable widget for displaying a savings goal card
class GoalCard extends StatelessWidget {
  final SavingsGoal goal;

  const GoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = goal.savedAmount / goal.targetAmount;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(goal.name, style: theme.textTheme.headlineMedium),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${goal.savedAmount.toStringAsFixed(0)} / ₹${goal.targetAmount.toStringAsFixed(0)}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12,
                backgroundColor: Colors.grey.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement contribution logic
                },
                icon: const Icon(Icons.add),
                label: const Text('Contribute'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.secondary,
                  side: BorderSide(color: theme.colorScheme.secondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
