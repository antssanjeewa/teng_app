import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The background color from the image
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // Center Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon Container with subtle glow/shadow
                Container(
                  padding: const EdgeInsets.all(AppSizes.containerPadding),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(
                      AppSizes.containerBorderRadius,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withAlpha(25),
                        blurRadius: AppSizes.shadowBlurRadius,
                        spreadRadius: AppSizes.shadowSpreadRadius,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.water_drop, // Closest Material icon to your logo
                    color: AppColors.accent,
                    size: AppSizes.splashIconSize,
                  ),
                ),
                const SizedBox(height: 32),
                // Title
                const Text(
                  'Tisera Engineering',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppSizes.titleFontSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  'Water Filtration Solutions',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppSizes.subtitleFontSize,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Elements (Loading bar and Version)
          Positioned(
            bottom: AppSizes.splashBottomSpacing,
            left: 40,
            right: 40,
            child: Column(
              children: [
                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppSizes.progressBarBorderRadius,
                  ),
                  child: AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: AppColors.surfaceDark,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.accent,
                        ),
                        minHeight: AppSizes.progressBarHeight,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Version Text
                Text(
                  'v1.0.0',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: AppSizes.versionFontSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
