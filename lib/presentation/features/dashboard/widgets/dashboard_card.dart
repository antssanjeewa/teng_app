import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_sizes.dart';

class DashboardCard extends StatefulWidget {
  final String title;
  final double value;
  final IconData icon;
  final Color? color;
  final String? badge;
  final Color? badgeColor;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.badge,
    this.badgeColor,
    this.onTap,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _countAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    // Parse the numeric value from the string
    final numValue = widget.value;

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _countAnimation = Tween<double>(begin: 0, end: numValue).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(DashboardCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animationController.dispose();
      _initializeAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(AppSizes.containerBorderRadius),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (widget.color ?? AppColors.primary).withAlpha(15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.color ?? AppColors.textPrimary,
                    size: 28,
                  ),
                ),
                const Spacer(),
                if (widget.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: widget.badgeColor?.withAlpha(50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.badge!,
                      style: TextStyle(
                        color: widget.badgeColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Text(widget.title, style: AppTextStyles.cardTitle),
            const SizedBox(height: 4),
            AnimatedBuilder(
              animation: _countAnimation,
              builder: (context, child) {
                return Text(
                  _countAnimation.value.toStringAsFixed(0),
                  style: AppTextStyles.cardValue,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

const _cardDecoration = BoxDecoration(
  color: AppColors.card,
  borderRadius: BorderRadius.all(
    Radius.circular(AppSizes.containerBorderRadius),
  ),
);
