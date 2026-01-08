import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0F1B2B);
    const cardColor = Color(0xFF162536);
    const primaryBlue = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header Section
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/200/300',
                        ), // Replace with image
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Kamal Perera',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Lead Technician',
                      style: TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Settings Sections
            _buildSectionHeader("ORGANIZATION"),
            _buildSettingsGroup([
              _buildSettingTile(Icons.business, "Company Profile", primaryBlue),
              _buildSettingTile(
                Icons.admin_panel_settings,
                "User Roles & Permissions",
                Colors.indigoAccent,
              ),
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader("TECHNICAL STANDARDS"),
            _buildSettingsGroup([
              _buildSettingTile(
                Icons.tune,
                "Component Templates",
                Colors.orange,
                subtitle: "Filters, membranes, pumps",
              ),
              _buildSettingTile(
                Icons.fact_check_outlined,
                "Service Checklists",
                Colors.teal,
              ),
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader("APPLICATION"),
            _buildSettingsGroup([
              _buildSettingTile(
                Icons.notifications,
                "Notifications",
                Colors.deepPurpleAccent,
                trailing: Switch(
                  value: true,
                  onChanged: (v) {},
                  activeColor: primaryBlue,
                ),
              ),
              _buildSettingTile(
                Icons.language,
                "Language",
                Colors.pinkAccent,
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("English", style: TextStyle(color: Colors.white38)),
                    Icon(Icons.chevron_right, color: Colors.white38),
                  ],
                ),
              ),
            ]),

            const SizedBox(height: 32),
            // Log Out Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.redAccent),
                label: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: cardColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'v1.0.4 - Tisera Engineering',
              style: TextStyle(color: Colors.white24, fontSize: 12),
            ),
            const Text(
              '© 2024 All rights reserved',
              style: TextStyle(color: Colors.white12, fontSize: 10),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF162536),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingTile(
    IconData icon,
    String title,
    Color iconBgColor, {
    String? subtitle,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconBgColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconBgColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            )
          : null,
      trailing:
          trailing ?? const Icon(Icons.chevron_right, color: Colors.white38),
      onTap: () {},
    );
  }
}
