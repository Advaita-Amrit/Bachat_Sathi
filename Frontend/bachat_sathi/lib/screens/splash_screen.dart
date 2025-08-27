import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart'; // We will create this next

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the onboarding screen after a 3-second delay.
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your App Logo
            Icon(
              Icons.shield_moon, // Placeholder for your logo
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            // App Name
            Text(
              'Bachat Sathi',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            // Tagline
            Text(
              'Your Personal AI Financial Advisor.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
