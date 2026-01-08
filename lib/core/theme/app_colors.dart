import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Brand
  static const Color primary = Color(0xFF1E88E5);
  static const Color secondary = Color(0xFF42A5F5);
  static const Color accent = Color(0xFF2196F3);

  /// Backgrounds
  static const Color background = Color(0xFF0E1621);
  static const Color backgroundDark = Color(0xFF0F1B2B);
  static const Color surface = Color(0xFF182233);
  static const Color surfaceDark = Color(0xFF162536);
  static const Color card = Color(0xFF1C2A3A);

  /// Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9AA4B2);
  static const Color textMuted = Color(0xFF6C7685);
  static const Color textSubtitle = Color(0xB3FFFFFF); // white70 equivalent

  /// Status
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF1C40F);
  static const Color error = Color(0xFFE74C3C);

  /// Tags / Badges
  static const Color urgent = Color(0xFFE53935);
  static const Color low = Color(0xFFFBC02D);

  /// Icons
  static const Color iconPrimary = Color(0xFFFFFFFF);
  static const Color iconSecondary = Color(0xFF9AA4B2);
  static const Color iconMuted = Color(0x4DFFFFFF); // white24 equivalent
  static const Color iconDisabled = Color(0x99FFFFFF); // white60 equivalent

  /// Input Fields
  static const Color inputBackground = Color(0xFF162536);
  static const Color inputBorder = Color(0x1FFFFFFF); // white12 equivalent
  static const Color inputHint = Color(0x4DFFFFFF); // white24 equivalent
}
