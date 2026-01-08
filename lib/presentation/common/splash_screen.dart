import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/route_names.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      GoRouter.of(context).go(RouteNames.login);
    }
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
                  child: const LinearProgressIndicator(
                    value: 0.9, // Adjust based on your loading logic
                    backgroundColor: AppColors.surfaceDark,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                    minHeight: AppSizes.progressBarHeight,
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
