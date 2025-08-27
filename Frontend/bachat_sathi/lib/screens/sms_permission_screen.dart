import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // This import is needed for the next step

class SmsPermissionScreen extends StatelessWidget {
  const SmsPermissionScreen({super.key});

  // This function will eventually handle the permission request.
  void _requestSmsPermission(BuildContext context) {
    // TODO: Implement actual SMS permission request using a package like 'permission_handler'.
    // For now, we'll simulate a successful permission grant and navigate to the dashboard.
    print("Requesting SMS permission...");

    // Navigate to the main dashboard after the user grants permission.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Icon(
                Icons.mark_chat_read_outlined,
                size: 100,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(height: 32),
              Text(
                'Automate Your Finances',
                textAlign: TextAlign.center,
                style: theme.textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Allow Bachat Sathi to read your transactional messages. We will only analyze financial alerts and completely ignore personal chats. Your privacy is our priority.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
              ),
              const Spacer(flex: 3),
              ElevatedButton(
                onPressed: () => _requestSmsPermission(context),
                child: const Text('Grant Permission'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Allow user to skip and go to dashboard
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ),
                  );
                },
                child: Text(
                  'Maybe Later',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
