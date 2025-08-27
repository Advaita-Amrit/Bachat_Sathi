import 'package:flutter/material.dart';
import 'sms_permission_screen.dart'; // This import is needed for the next step

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.shield_moon,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue your financial journey.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 48),

                  // Social Login Buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement Google Sign In
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SmsPermissionScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.g_mobiledata,
                      color: Colors.white,
                    ), // Placeholder for Google Icon
                    label: const Text('Continue with Google'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4285F4),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement Apple Sign In
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SmsPermissionScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.apple, color: Colors.white),
                    label: const Text('Continue with Apple'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 32),
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
                  const SizedBox(height: 32),

                  // Email and Password Fields
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Email/Password Login
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SmsPermissionScreen(),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 24),

                  // Sign Up Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: theme.textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to Sign Up Screen
                        },
                        child: Text(
                          'Sign Up',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
