import 'package:flutter/material.dart';
import 'login_screen.dart'; // This line was missing

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data for the onboarding slides
  final List<Map<String, dynamic>> _onboardingData = [
    {
      "icon": Icons.sms_outlined,
      "title": "Automatically track expenses from messages.",
      "graphic":
          Icons.donut_large_outlined, // Placeholder for SMS to charts graphic
    },
    {
      "icon": Icons.chat_bubble_outline,
      "title": "Get personalized AI-driven advice.",
      "graphic": Icons.lightbulb_outline, // Placeholder for chat bubble graphic
    },
    {
      "icon": Icons.rocket_launch_outlined,
      "title": "Set and crush your financial goals.",
      "graphic": Icons.flag_outlined, // Placeholder for rocket ship graphic
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingSlide(
                    icon: _onboardingData[index]['icon'],
                    title: _onboardingData[index]['title'],
                    graphic: _onboardingData[index]['graphic'],
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingData.length,
                        (index) => buildDot(index, context),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage == _onboardingData.length - 1) {
                            _navigateToLogin();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(
                          _currentPage == _onboardingData.length - 1
                              ? 'Get Started'
                              : 'Next',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: _navigateToLogin,
                      child: Text(
                        'Skip',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for the page indicator dots
  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 10,
      width: _currentPage == index ? 24 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Theme.of(context).colorScheme.primary
            : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

// A reusable widget for each onboarding slide
class OnboardingSlide extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData graphic;

  const OnboardingSlide({
    super.key,
    required this.icon,
    required this.title,
    required this.graphic,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(graphic, size: 150, color: theme.colorScheme.secondary),
          const SizedBox(height: 60),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
