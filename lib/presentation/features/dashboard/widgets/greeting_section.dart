import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/spacing.dart';

class GreetingSection extends StatefulWidget {
  const GreetingSection({super.key});

  @override
  State<GreetingSection> createState() => _GreetingSectionState();
}

class _GreetingSectionState extends State<GreetingSection> {
  late String _currentDate;
  final String _userName = 'Technician';

  @override
  void initState() {
    super.initState();
    _currentDate = _formatDate();
  }

  String _formatDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, d\'th\' MMM yyyy');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Spacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning,',
            style: AppTextStyles.headline.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            _userName,
            style: AppTextStyles.headline.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          Spacing.v8,
          Text(
            _currentDate,
            style: AppTextStyles.subHeadline.copyWith(
              color: AppColors.textMuted,
            ),
          ),

          Spacing.v16,
          Container(
            padding: Spacing.cardPadding,
            decoration: BoxDecoration(
              color: AppColors.textPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
                Spacing.h12,
                Expanded(
                  child: Text(
                    'Next service: Filter replacement at Colombo 03',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: AppColors.textPrimary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
