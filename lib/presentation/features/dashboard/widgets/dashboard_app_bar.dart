import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.person, color: AppColors.textPrimary),
      ),
      title: Text('Tisera Engineering', style: AppTextStyles.appBarTitle),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: AppColors.textPrimary.withAlpha(15),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
