import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const BachatSathiApp());
}

class BachatSathiApp extends StatelessWidget {
  const BachatSathiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bachat Sathi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the overall dark theme for the application.
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // Charcoal Black
        primaryColor: const Color(0xFF27AE60), // Neon Green
        // Define font family
        fontFamily: 'Inter',

        // Define color scheme
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF27AE60), // Neon Green
          secondary: Color(0xFF2980B9), // Electric Blue
          background: Color(0xFF121212), // Charcoal Black
          surface: Color(0xFF1E1E1E), // Slightly lighter for cards
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.white,
          onSurface: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
        ),

        // Define text theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white70),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white60),
          labelLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Define card theme
        cardTheme: CardThemeData(
          color: const Color(0xFF1E1E1E),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          shadowColor: Colors.black.withOpacity(0.5),
        ),

        // Define button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF27AE60), // Neon Green
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),

        // Floating Action Button Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF2980B9), // Electric Blue
          foregroundColor: Colors.white,
        ),

        // Input Decoration Theme for TextFields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
