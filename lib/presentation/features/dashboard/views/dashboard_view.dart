import 'package:flutter/material.dart';

import '../../../../core/router/pages.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/greeting_section.dart';
import '../widgets/schedule_header.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/schedule_tile.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DashboardAppBar(),
      body: SingleChildScrollView(
        padding: Spacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingSection(),
            Spacing.v24,

            /// Stats Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                DashboardCard(
                  title: 'TOTAL INSTALLED',
                  value: 1240,
                  icon: Icons.water_drop,
                  color: AppColors.primary,
                  onTap: () => Pages.locations.go(context),
                ),
                DashboardCard(
                  title: 'PENDING REPAIRS',
                  value: 5,
                  icon: Icons.build,
                  color: AppColors.urgent,
                  badge: 'URGENT',
                  badgeColor: AppColors.urgent,
                  onTap: () => Pages.jobs.go(context),
                ),
                DashboardCard(
                  title: 'DUE SOON',
                  value: 3,
                  icon: Icons.calendar_today,
                  color: AppColors.warning,
                  onTap: () => Pages.jobs.go(context),
                ),
                DashboardCard(
                  title: 'INVENTORY',
                  value: 2,
                  icon: Icons.inventory,
                  badge: 'LOW',
                  badgeColor: AppColors.low,
                  onTap: () => Pages.stock.go(context),
                ),
              ],
            ),

            Spacing.v32,
            const Text('Quick Actions', style: AppTextStyles.headline),

            Spacing.v16,
            InkWell(
              onTap: () => Pages.locationCreate.go(context),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(45),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add_circle, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Installation',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Register a new RO plant setup',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),

            Spacing.v16,
            Row(
              children: [
                Expanded(
                  child: QuickActionCard(
                    title: 'Log Repair',
                    subtitle: 'Create service ticket',
                    icon: Icons.build_circle,
                    color: AppColors.urgent,
                    onTap: () => Pages.jobs.go(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: QuickActionCard(
                    title: 'Check Stock',
                    subtitle: 'View spare parts',
                    icon: Icons.assignment,
                    color: AppColors.secondary,
                    onTap: () => Pages.stock.go(context),
                  ),
                ),
              ],
            ),

            Spacing.v32,
            ScheduleHeader(),

            Spacing.v16,
            const ScheduleTile(
              date: 'OCT 24',
              title: 'Filter Replacement',
              location: 'Colombo 03, Kandy Road',
              time: '10:00 AM',
            ),
            const ScheduleTile(
              date: 'OCT 24',
              title: 'System Inspection',
              location: 'Galle Road, Mount Lavinia',
              status: 'Completed',
            ),
          ],
        ),
      ),
    );
  }
}
