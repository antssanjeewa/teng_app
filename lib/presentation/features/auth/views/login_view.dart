import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/validators.dart';
import '../viewModels/login_view_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Handle the logic and navigation here
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final vm = context.read<LoginViewModel>();
    final success = await vm.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success && mounted) {
      // GoRouter.of(context).go(RouteNames.home);
    } else if (vm.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(vm.errorMessage!),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.screenHorizontalPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const _LoginHeader(), // Extracted for readability
                const SizedBox(height: AppSizes.extraLargeSpacing),

                _buildTextField(
                  label: "Email or Username",
                  controller: _emailController,
                  hintText: "tech@tisera.lk",
                  prefixIcon: Icons.email_outlined,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: AppSizes.sectionSpacing),

                _buildTextField(
                  label: "Password",
                  controller: _passwordController,
                  hintText: "••••••••",
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onSuffixTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  validator: Validators.validatePassword,
                ),

                const _ForgotPasswordButton(),
                const SizedBox(height: AppSizes.sectionSpacing),

                // Use Selector to only rebuild the button when isLoading changes
                Selector<LoginViewModel, bool>(
                  selector: (_, viewModel) => viewModel.isLoading,
                  builder: (context, isLoading, child) {
                    return _LoginButton(
                      isLoading: isLoading,
                      onPressed: _handleLogin,
                    );
                  },
                ),

                const _LoginFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Refactored TextField to include the label inside it for cleaner View code
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixTap,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon, color: AppColors.iconDisabled),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: onSuffixTap,
                  )
                : null,
            // ... rest of your decoration styling
          ),
        ),
      ],
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Container(
          height: AppSizes.logoContainerSize,
          width: AppSizes.logoContainerSize,
          decoration: BoxDecoration(
            color: AppColors.accent.withAlpha(200),
            borderRadius: BorderRadius.circular(AppSizes.containerBorderRadius),
          ),
          child: const Icon(
            Icons.settings_input_component,
            color: AppColors.textPrimary,
            size: AppSizes.logoIconSize,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Tisera Engineering',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppSizes.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Sign in to manage water filtration\ninstallations',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSubtitle,
            fontSize: AppSizes.subtitleFontSize,
          ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _LoginButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Log In',
                style: TextStyle(
                  fontSize: AppSizes.buttonFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          /* TODO: Implement navigation */
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Color(0xFF2196F3)),
        ),
      ),
    );
  }
}

class _LoginFooter extends StatelessWidget {
  const _LoginFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSizes.splashBottomSpacing),
        const Divider(color: Colors.white12),
        const SizedBox(height: 20),
        const Text(
          'App Version 1.0.2',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: AppSizes.versionFontSize,
          ),
        ),
      ],
    );
  }
}
