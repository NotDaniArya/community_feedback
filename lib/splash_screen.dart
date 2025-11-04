import 'package:community_feedback/features/auth/presentation/screens/login/login_screen.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to home after 7 seconds
    Future.delayed(const Duration(seconds: 7), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              TColors.primaryColor.withOpacity(0.8),
              TColors.primaryColor.withOpacity(0.4),
              TColors.primaryColor.withOpacity(0.1),
              TColors.backgroundColor,
            ],
            stops: const [0.0, 0.3, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: TColors.primaryColor.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/logos/app_logo.png',
                        width: 120,
                        height: 120,
                      ),
                    )
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.easeOut)
                    .fadeIn(duration: 500.ms),
                const SizedBox(height: TSizes.largeSpace),
                LoadingAnimationWidget.staggeredDotsWave(
                      color: TColors.primaryColor,
                      size: 50,
                    )
                    .animate()
                    .scale(
                      delay: 600.ms,
                      duration: 200.ms,
                      curve: Curves.easeOut,
                    )
                    .fadeIn(duration: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
