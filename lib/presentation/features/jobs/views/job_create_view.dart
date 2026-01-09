import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../viewmodel/job_create_viewmodel.dart';

class JobCreateView extends StatelessWidget {
  const JobCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Create Repair Request',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Consumer<JobCreateViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: Spacing.screenPadding,
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel("CUSTOMER SELECTION"),
                        _buildSearchBar(),

                        Spacing.v24,
                        _buildSectionLabel("SITE LOCATION"),
                        _buildLocationCard(),

                        Spacing.v24,
                        _buildSectionLabel("ISSUE CATEGORY"),
                        _buildCategoryGrid(viewModel),

                        Spacing.v24,
                        _buildSectionLabel("DETAILED DESCRIPTION"),
                        _buildDescriptionField(viewModel),

                        Spacing.v24,
                        _buildSectionLabel("ESTIMATED COST (OPTIONAL)"),
                        _buildTextField(
                          "ESTIMATED COST",
                          "0.00",
                          viewModel.estimatedCostController,
                          keyboardType: TextInputType.number,
                          prefix: "Rs. ",
                        ),

                        Spacing.v24,
                        _buildSectionLabel("SPECIAL INSTRUCTIONS"),
                        _buildTextField(
                          "SPECIAL INSTRUCTIONS",
                          "Add any specific notes...",
                          viewModel.specialInstructionsController,
                          maxLines: 3,
                        ),

                        Spacing.v24,
                        _buildSectionLabel("CAPTURE ISSUE (OPTIONAL)"),
                        _buildPhotoSection(viewModel),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              _buildSubmitButton(viewModel, context),
            ],
          );
        },
      ),
    );
  }

  // --- UI Component Helpers ---

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search customer name or ID...',
        hintStyle: const TextStyle(color: AppColors.textMuted),
        prefixIcon: const Icon(Icons.person_search, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on, color: AppColors.primary, size: 20),
          Spacing.h12,
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select a customer to view address",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Location will be automatically detected based on the customer record.",
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType? keyboardType,
    String? prefix,
    int maxLines = 1,
    bool requiredField = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacing.v8,
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textMuted),
            prefixText: prefix,
            prefixStyle: const TextStyle(color: AppColors.textMuted),
            filled: true,
            fillColor: AppColors.surfaceDark,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          validator: requiredField
              ? (v) => v == null || v.trim().isEmpty ? 'Required' : null
              : null,
        ),
        Spacing.v12,
      ],
    );
  }

  Widget _buildCategoryGrid(JobCreateViewModel vm) {
    final categories = [
      {'name': 'Leakage', 'icon': Icons.home_repair_service},
      {'name': 'Low Pressure', 'icon': Icons.speed},
      {'name': 'Electrical', 'icon': Icons.bolt},
      {'name': 'Filter Change', 'icon': Icons.filter_alt},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        bool isSelected = vm.selectedCategory == cat['name'];
        return GestureDetector(
          onTap: () => vm.selectCategory(cat['name'] as String),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : Colors.white.withAlpha(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  cat['icon'] as IconData,
                  color: isSelected ? AppColors.primary : AppColors.textMuted,
                  size: 18,
                ),
                Spacing.h8,
                Text(
                  cat['name'] as String,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescriptionField(JobCreateViewModel vm) {
    return TextField(
      maxLines: 4,
      style: const TextStyle(color: Colors.white),
      controller: vm.descriptionController,
      decoration: InputDecoration(
        hintText: 'Describe the issue in detail for the technician...',
        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
        filled: true,
        fillColor: AppColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPhotoSection(JobCreateViewModel vm) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildAddPhotoButton(),
          // In a real app, map vm.photos here
          // Example of a selected photo:
          Container(
            margin: const EdgeInsets.only(left: 12),
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // image: const DecorationImage(
              //   image: NetworkImage(
              //     'https://via.placeholder.com/100',
              //   ), // Replace with local file path
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.white, size: 20),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withAlpha(15),
          style: BorderStyle.solid,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo, color: AppColors.textMuted),
          SizedBox(height: 8),
          Text(
            "Add Photo",
            style: TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(JobCreateViewModel vm, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: vm.isSubmitting
            ? null
            : () async {
                if (!vm.formKey.currentState!.validate()) return;
                final success = await vm.submitRequest();
                if (success && context.mounted) {
                  Navigator.pop(context);
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: vm.isSubmitting
            ? const CircularProgressIndicator(color: Colors.white)
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send, size: 18, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Submit Request",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
