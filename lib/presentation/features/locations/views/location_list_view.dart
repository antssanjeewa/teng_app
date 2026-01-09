import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/spacing.dart';

class LocationListView extends StatelessWidget {
  const LocationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Installations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: AppColors.accent,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // List / Map Toggle
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildToggleItem("List", Icons.list, isSelected: true),
                  _buildToggleItem(
                    "Map",
                    Icons.map_outlined,
                    isSelected: false,
                  ),
                ],
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search customer or location',
                hintStyle: const TextStyle(color: Colors.white24),
                prefixIcon: const Icon(Icons.search, color: Colors.white24),
                filled: true,
                fillColor: AppColors.surfaceDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filter Dropdowns Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildDropdownFilter("District: All"),
                Spacing.h8,
                _buildDropdownFilter("Status: All"),
                Spacing.h8,
                _buildIconButtonFilter(),
              ],
            ),
          ),

          Spacing.v16,

          // Installations List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildInstallCard(
                  title: "Sampath Traders",
                  id: "RO-2023-089",
                  location: "45 Galle Road, Colombo 03",
                  date: "Installed: 12 Jan 2023",
                  icon: Icons.store,
                  status: "Service Due",
                  statusColor: Colors.orangeAccent,
                  onTap: () => context.goNamed(
                    RouteNames.locationDetail,
                    pathParameters: {'id': 'RO-2023-089'},
                  ),
                ),
                _buildInstallCard(
                  title: "Kandy City Hospital",
                  id: "RO-2023-156",
                  location: "Peradeniya Rd, Kandy",
                  date: "Installed: 05 Aug 2023",
                  icon: Icons.local_hospital,
                  status: "Under Warranty",
                  statusColor: Colors.blueAccent,
                  onTap: () => context.goNamed(
                    RouteNames.locationDetail,
                    pathParameters: {'id': 'RO-2023-156'},
                  ),
                ),
                _buildInstallCard(
                  title: "Villa Hotels",
                  id: "RO-2022-045",
                  location: "12 Beach Road, Negombo",
                  date: "Installed: 22 Nov 2022",
                  icon: Icons.apartment,
                  status: "Active",
                  statusColor: Colors.greenAccent,
                  onTap: () => context.goNamed(
                    RouteNames.locationDetail,
                    pathParameters: {'id': 'RO-2022-045'},
                  ),
                ),
                _buildInstallCard(
                  title: "Nugegoda Supermarket",
                  id: "RO-2021-012",
                  location: "High Level Rd, Nugegoda",
                  date: "Installed: 01 Mar 2021",
                  icon: Icons.shopping_cart,
                  status: "Service Due",
                  statusColor: Colors.orangeAccent,
                  onTap: () => context.goNamed(
                    RouteNames.locationDetail,
                    pathParameters: {'id': 'RO-2021-012'},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildToggleItem(
    String label,
    IconData icon, {
    required bool isSelected,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF454F5D) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white38,
              size: 18,
            ),
            Spacing.h8,
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownFilter(String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white38,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButtonFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: const Row(
        children: [
          Text("Filter", style: TextStyle(color: Colors.white70, fontSize: 12)),
          Spacing.h4,
          Icon(Icons.sort, color: Colors.white38, size: 16),
        ],
      ),
    );
  }

  Widget _buildInstallCard({
    required String title,
    required String id,
    required String location,
    required String date,
    required IconData icon,
    required String status,
    required Color statusColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent.withAlpha(15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.accent),
            ),
            Spacing.h16,
            // Info Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "ID: #$id",
                    style: const TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                  Spacing.v12,
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white38,
                        size: 14,
                      ),
                      Spacing.h4,
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Spacing.v4,
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.white38,
                        size: 14,
                      ),
                      Spacing.h4,
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
