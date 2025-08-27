import 'package:flutter/material.dart';
import 'dashboard_home_screen.dart'; // Corrected Path
import 'ai_advisor_screen.dart'; // Corrected Path
import 'goals_screen.dart'; // Corrected Path
import 'add_expense_modal.dart'; // Corrected Path

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // List of the main screens accessible from the bottom nav bar
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardHomeScreen(),
    AiAdvisorScreen(),
    GoalsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAddExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        return const AddExpenseModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseModal,
        tooltip: 'Add Expense',
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: const Color(0xFF1E1E1E),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () => _onItemTapped(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard_rounded,
                          color: _selectedIndex == 0
                              ? theme.colorScheme.primary
                              : Colors.grey,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            color: _selectedIndex == 0
                                ? theme.colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Right Tab bar icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () => _onItemTapped(1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_rounded,
                          color: _selectedIndex == 1
                              ? theme.colorScheme.primary
                              : Colors.grey,
                        ),
                        Text(
                          'AI Advisor',
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? theme.colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () => _onItemTapped(2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flag_rounded,
                          color: _selectedIndex == 2
                              ? theme.colorScheme.primary
                              : Colors.grey,
                        ),
                        Text(
                          'Goals',
                          style: TextStyle(
                            color: _selectedIndex == 2
                                ? theme.colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
