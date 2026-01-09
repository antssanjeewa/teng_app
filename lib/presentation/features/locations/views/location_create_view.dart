import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../viewmodels/location_create_view_modal.dart';

class LocationCreateView extends StatefulWidget {
  const LocationCreateView({super.key});

  @override
  State<LocationCreateView> createState() => _LocationCreateViewState();
}

class _LocationCreateViewState extends State<LocationCreateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Consumer<LocationCreateViewModel>(
        builder: (context, vm, _) {
          return Stack(
            children: [
              _Content(vm: vm, formKey: vm.formKey),
              if (vm.isSaving) const _LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const BackButton(color: Colors.white),
      title: const Text(
        'Add Installation',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Help', style: TextStyle(color: AppColors.accent)),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                   CONTENT                                  */
/* -------------------------------------------------------------------------- */

class _Content extends StatelessWidget {
  final LocationCreateViewModel vm;
  final GlobalKey<FormState> formKey;

  const _Content({required this.vm, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Spacing.screenPadding,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _CustomerDetails(vm),
            Spacing.v32,
            _SiteLocation(vm),
            Spacing.v32,
            _SystemDetails(vm, formKey),
            Spacing.v32,
            _ErrorMessage(vm),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                   SECTIONS                                  */
/* -------------------------------------------------------------------------- */

class _CustomerDetails extends StatelessWidget {
  final LocationCreateViewModel vm;

  const _CustomerDetails(this.vm);

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      children: [
        const _SectionHeader(Icons.person, 'CUSTOMER DETAILS'),
        _TextField(
          label: 'CUSTOMER NAME',
          hint: 'Enter full name',
          controller: vm.customerNameController,
          requiredField: true,
        ),
        Spacing.v16,
        _TextField(
          label: 'CONTACT NUMBER',
          hint: '+94 XX XXX XXXX',
          controller: vm.customerContactController,
          keyboardType: TextInputType.phone,
        ),
        Spacing.v24,
        const _SectionHeader(
          null,
          'DONATION INFORMATION (IF APPLICABLE)',
          isSub: true,
        ),
        _TextField(
          label: 'DONOR NAME',
          hint: "Enter donor's name",
          controller: vm.donorNameController,
        ),
        Spacing.v16,
        _TextField(
          label: 'DONOR CONTACT NUMBER',
          hint: '+94 XX XXX XXXX',
          controller: vm.donorContactController,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}

class _SiteLocation extends StatelessWidget {
  final LocationCreateViewModel vm;

  const _SiteLocation(this.vm);

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      children: [
        const _SectionHeader(Icons.location_on, 'SITE LOCATION'),
        _MultilineField(
          label: 'ADDRESS',
          hint: 'Street name, City',
          controller: vm.addressController,
          hasPicker: true,
          requiredField: true,
        ),
        Spacing.v16,
        _Dropdown(
          label: 'DISTRICT',
          hint: 'Select District',
          value: vm.selectedDistrict,
          onChanged: vm.setDistrict,
          items: const [],
        ),
      ],
    );
  }
}

class _SystemDetails extends StatelessWidget {
  final LocationCreateViewModel vm;
  final GlobalKey<FormState> formKey;

  const _SystemDetails(this.vm, this.formKey);

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      children: [
        const _SectionHeader(Icons.settings, 'SYSTEM DETAILS'),
        _Dropdown(
          label: 'RO PLANT MODEL',
          hint: 'Select Model',
          value: vm.selectedModel,
          onChanged: vm.setModel,
          items: const [],
        ),
        Spacing.v16,
        _DateField(vm),
        Spacing.v16,
        _TextField(
          label: 'ESTIMATED COST (OPTIONAL)',
          hint: '0.00',
          prefix: 'Rs. ',
          controller: vm.estimatedCostController,
          keyboardType: TextInputType.number,
        ),
        Spacing.v16,
        _MultilineField(
          label: 'SPECIAL INSTRUCTIONS',
          hint: 'Add any specific site notes...',
          controller: vm.specialInstructionsController,
        ),
        Spacing.v32,
        _SaveButton(vm, formKey),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                COMPONENTS                                   */
/* -------------------------------------------------------------------------- */

class _SaveButton extends StatelessWidget {
  final LocationCreateViewModel vm;
  final GlobalKey<FormState> formKey;

  const _SaveButton(this.vm, this.formKey);

  Future<void> _onPressed(BuildContext context) async {
    if (vm.isSaving) return;
    if (!formKey.currentState!.validate()) return;

    try {
      await vm.saveInstallation();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Save failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: vm.isSaving ? null : () => _onPressed(context),
      icon: vm.isSaving
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : const Icon(Icons.save),
      label: const Text(
        'Save Installation',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final LocationCreateViewModel vm;

  const _ErrorMessage(this.vm);

  @override
  Widget build(BuildContext context) {
    if (vm.errorMessage == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(vm.errorMessage!, style: const TextStyle(color: Colors.red)),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              REUSABLE UI                                    */
/* -------------------------------------------------------------------------- */

class _SectionCard extends StatelessWidget {
  final List<Widget> children;

  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withAlpha(125),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: children),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData? icon;
  final String title;
  final bool isSub;

  const _SectionHeader(this.icon, this.title, {this.isSub = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.accent, size: 18),
            Spacing.h8,
          ],
          Text(
            title,
            style: TextStyle(
              color: isSub ? AppColors.textMuted : AppColors.accent,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? prefix;
  final TextInputType? keyboardType;
  final bool requiredField;

  const _TextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.prefix,
    this.keyboardType,
    this.requiredField = false,
  });

  @override
  Widget build(BuildContext context) {
    return _FieldWrapper(
      label: label,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: _inputDecoration(hint, prefix: prefix),
        validator: requiredField
            ? (v) => v == null || v.trim().isEmpty ? 'Required' : null
            : null,
      ),
    );
  }
}

class _MultilineField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool hasPicker;
  final bool requiredField;

  const _MultilineField({
    required this.label,
    required this.hint,
    required this.controller,
    this.hasPicker = false,
    this.requiredField = false,
  });

  @override
  Widget build(BuildContext context) {
    return _FieldWrapper(
      label: label,
      child: TextFormField(
        controller: controller,
        maxLines: 3,
        style: const TextStyle(color: Colors.white),
        decoration: _inputDecoration(
          hint,
          suffixIcon: hasPicker
              ? const Icon(Icons.gps_fixed, color: AppColors.accent)
              : null,
        ),
        validator: requiredField
            ? (v) => v == null || v.trim().isEmpty ? 'Required' : null
            : null,
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final ValueChanged<String> onChanged;
  final List<DropdownMenuItem<String>> items;

  const _Dropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return _FieldWrapper(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            hint: Text(hint, style: _hintStyle),
            dropdownColor: AppColors.surfaceDark,
            items: items,
            onChanged: (v) => v != null ? onChanged(v) : null,
          ),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final LocationCreateViewModel vm;

  const _DateField(this.vm);

  @override
  Widget build(BuildContext context) {
    return _FieldWrapper(
      label: 'INSTALLATION DATE',
      child: TextField(
        readOnly: true,
        controller: TextEditingController(
          text: vm.installationDate == null
              ? ''
              : vm.installationDate!.toLocal().toString().split(' ')[0],
        ),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
            initialDate: vm.installationDate ?? DateTime.now(),
          );
          if (date != null) vm.setInstallationDate(date);
        },
        decoration: _inputDecoration(
          'Select Date',
          suffixIcon: const Icon(Icons.calendar_month),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                   HELPERS                                   */
/* -------------------------------------------------------------------------- */

class _FieldWrapper extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldWrapper({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelStyle),
        Spacing.v8,
        child,
      ],
    );
  }
}

const _labelStyle = TextStyle(
  color: AppColors.textMuted,
  fontSize: 10,
  fontWeight: FontWeight.bold,
);

const _hintStyle = TextStyle(color: AppColors.textMuted, fontSize: 14);

InputDecoration _inputDecoration(
  String hint, {
  String? prefix,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: _hintStyle,
    prefixText: prefix,
    prefixStyle: _hintStyle,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: AppColors.surfaceDark,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  );
}
