import 'package:flutter/material.dart';
import '../../../core/config/connected_feature_dependency_container.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/localization/app_strings.dart';
import '../../../domain/use_cases/auth_use_cases.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, this.getCurrentAuthUserUseCase});

  final GetCurrentAuthUserUseCase? getCurrentAuthUserUseCase;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final GetCurrentAuthUserUseCase _getCurrentAuthUserUseCase;
  double _bgOpacity = 0.0;
  bool _isCheckingAuth = true;

  @override
  void initState() {
    super.initState();
    final container = ConnectedFeatureDependencyContainer.forCurrentMode();
    _getCurrentAuthUserUseCase =
        widget.getCurrentAuthUserUseCase ??
        GetCurrentAuthUserUseCase(container.auth);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _checkExistingUser();

    // Trigger fade in for background
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _bgOpacity = 1.0;
        });
      }
    });
  }

  Future<void> _checkExistingUser() async {
    final user = await _getCurrentAuthUserUseCase.execute();
    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
      return;
    }

    setState(() {
      _isCheckingAuth = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            child: Image.asset('assets/images/app_logo.png', fit: BoxFit.cover),
          ),

          Column(
            children: [
              // 🟢 مسافة فوق
              const Spacer(flex: 5),

              // 🟢 الزرار بتأثير Scale
              ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.05).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                ),
                child: _isCheckingAuth
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.login_outlined),
                          label: Text(
                            context.tr('welcomeAccountEntry'),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            AppRoutes.createAccount,
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: Color.lerp(
                              const Color(0xFF303065),
                              const Color(0xFF2C2C5C),
                              0.4,
                            ),
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 12,
                            shadowColor: Colors.black.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
              ),

              // 🟢 مسافة تحت
              const SizedBox(height: 45),
            ],
          ),
        ],
      ),
    );
  }
}
