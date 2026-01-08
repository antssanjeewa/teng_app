import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/spacing.dart';

class ScheduleTile extends StatelessWidget {
  final String date;
  final String title;
  final String location;
  final String time;
  final String? status;

  const ScheduleTile({
    super.key,
    required this.date,
    required this.title,
    required this.location,
    this.time = '',
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Spacing.cardPadding,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        border: Border.all(color: AppColors.surfaceDark, width: 1),
      ),
      child: Row(
        children: [
          // Date Column
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color: status == 'Completed'
                  ? AppColors.success.withAlpha(15)
                  : AppColors.primary.withAlpha(15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  date.split(' ')[0], // OCT
                  style: TextStyle(
                    color: status == 'Completed'
                        ? AppColors.success
                        : AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date.split(' ')[1], // 24
                  style: AppTextStyles.cardValue.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.cardTitle.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.iconSecondary,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status
          if (status != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: status == 'Completed'
                    ? AppColors.success.withAlpha(15)
                    : AppColors.warning.withAlpha(15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status!,
                style: TextStyle(
                  color: status == 'Completed'
                      ? AppColors.success
                      : AppColors.warning,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: AppColors.iconSecondary,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  time,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
