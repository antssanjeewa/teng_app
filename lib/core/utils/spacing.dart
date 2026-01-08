import 'package:flutter/widgets.dart';

class Spacing {
  Spacing._();

  /// Base spacing unit
  static const double _unit = 8;

  /// Vertical spacing
  static const SizedBox v4 = SizedBox(height: _unit * 0.5);
  static const SizedBox v8 = SizedBox(height: _unit);
  static const SizedBox v12 = SizedBox(height: _unit * 1.5);
  static const SizedBox v16 = SizedBox(height: _unit * 2);
  static const SizedBox v24 = SizedBox(height: _unit * 3);
  static const SizedBox v32 = SizedBox(height: _unit * 4);

  /// Horizontal spacing
  static const SizedBox h4 = SizedBox(width: _unit * 0.5);
  static const SizedBox h8 = SizedBox(width: _unit);
  static const SizedBox h12 = SizedBox(width: _unit * 1.5);
  static const SizedBox h16 = SizedBox(width: _unit * 2);
  static const SizedBox h24 = SizedBox(width: _unit * 3);
  static const SizedBox h32 = SizedBox(width: _unit * 4);

  /// EdgeInsets (padding / margin)
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 16,
  );

  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );
}
