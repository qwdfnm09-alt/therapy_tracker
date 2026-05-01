import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../home/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _bgOpacity = 0.0;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // Trigger fade in for background
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _bgOpacity = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateOnce() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.2, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              ),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                child: child,
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🟢 1. Fade Animation للصورة (تظهر تدريجي)
          AnimatedOpacity(
            opacity: _bgOpacity,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            child: Image.asset(
              'assets/images/app_logo.png',
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              // 🟢 مسافة فوق
              const Spacer(flex: 5),

              // 🟢 الزرار بتأثير Scale
              ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.05).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton.icon(
                    label: Text(context.tr('startUsage'),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async {
                      await Future.delayed(const Duration(milliseconds: 300));
                      _navigateOnce();
                    },
                    style:  FilledButton.styleFrom(
                      backgroundColor: Color.lerp(theme.colorScheme.primary, Colors.black, 0.4),
                      foregroundColor: theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 12,
                      shadowColor:  Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),

              // 🟢 مسافة تحت
              const Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
