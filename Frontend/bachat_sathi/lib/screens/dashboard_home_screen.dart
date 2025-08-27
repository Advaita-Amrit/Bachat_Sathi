import 'package:flutter/material.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              // TODO: Handle notifications
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Financial Health Score Section
          _buildFinancialHealthScore(theme),
          const SizedBox(height: 24),

          // Interactive Expense Chart Section
          _buildExpenseChart(theme),
          const SizedBox(height: 24),

          // AI Insight Card
          _buildAiInsightCard(theme),
          const SizedBox(height: 24),

          // Recent Transactions Section
          _buildRecentTransactions(theme),
        ],
      ),
    );
  }

  Widget _buildFinancialHealthScore(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 0.78,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                  ),
                  Center(
                    child: Text(
                      '78/100',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Financial Health',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You are doing great this month!',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseChart(ThemeData theme) {
    // Placeholder for a real chart widget like 'fl_chart'
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Month\'s Spending',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Total Spent: ₹15,430',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // In a real app, you would use a charting library here.
            // This is a simplified representation.
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  '[Interactive Donut Chart Placeholder]',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAiInsightCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: const Color(0xFFF39C12),
              size: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Financial Tip',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFFF39C12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "You've spent ₹1,250 on restaurants this month. Cooking at home for the rest of the week could save you ₹800 for your savings goal!",
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Transactions', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTransactionItem(
          theme,
          Icons.fastfood,
          'Zomato Order',
          'Food',
          '₹450.00',
        ),
        const Divider(color: Colors.white12),
        _buildTransactionItem(
          theme,
          Icons.receipt_long,
          'Electricity Bill',
          'Bills',
          '₹1,200.00',
        ),
        const Divider(color: Colors.white12),
        _buildTransactionItem(
          theme,
          Icons.movie_outlined,
          'Movie Tickets',
          'Entertainment',
          '₹650.00',
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    ThemeData theme,
    IconData icon,
    String merchant,
    String category,
    String amount,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.colorScheme.secondary.withOpacity(0.2),
            child: Icon(icon, color: theme.colorScheme.secondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  merchant,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(category, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          Text(
            amount,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
