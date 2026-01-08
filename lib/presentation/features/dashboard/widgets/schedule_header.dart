import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ScheduleHeader extends StatelessWidget {
  const ScheduleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Today\'s Schedule', style: AppTextStyles.headline),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text('View All', style: TextStyle(color: AppColors.primary)),
        ),
      ],
    );
  }
}
