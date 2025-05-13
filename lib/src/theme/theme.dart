import 'package:flutter/material.dart';

/// The Filter List theme components.
///
/// This file exports all the theme-related classes for the filter list package.
/// The theme hierarchy is:
/// - FilterListTheme (top level)
///   - ChoiceChipTheme
///   - HeaderTheme
///   - ControlButtonBarTheme
///     - ControlButtonTheme
///
/// When accessing themes, use the safeOf methods to ensure a fallback to default
/// themes when none are explicitly provided.
export 'choice_chip_theme.dart';
export 'contol_button_theme.dart';
export 'control_button_bar_theme.dart';
export 'filter_list_delegate_theme.dart';
export 'filter_list_theme.dart';
export 'header_theme.dart';

extension ColorExtension on Color {
  Color withTransparency(double opacity) =>
      withAlpha((255.0 * opacity).round());
}
