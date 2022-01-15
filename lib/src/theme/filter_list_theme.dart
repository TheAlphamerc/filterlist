import 'package:filter_list/src/theme/choice_chip_theme.dart';
import 'package:filter_list/src/theme/control_button_bar_theme.dart';
import 'package:filter_list/src/theme/header_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Applies a [FilterListThemeData] to descendent Filter list widgets.
class FilterListTheme extends InheritedWidget {
  /// Builds a [FilterListTheme].
  const FilterListTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// The [FilterListThemeData] styling for this theme.
  final FilterListThemeData data;

  @override
  bool updateShouldNotify(FilterListTheme oldWidget) => data != oldWidget.data;

  /// Retrieves the [FilterListThemeData] from the closest ancestor
  /// [FilterListTheme] widget.
  static FilterListThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<FilterListTheme>();

    assert(
      theme != null,
      'You must have a FilterListTheme widget at the top of your widget tree',
    );

    return theme!.data;
  }
}

/// Defines the configuration of the overall visual [FilterListTheme] for a
/// particular widget subtree.
class FilterListThemeData with Diagnosticable {
  /// Builds a [FilterListThemeData] with default values, if none are given.
  factory FilterListThemeData({
    required BuildContext context,
    Brightness? brightness,
    IconThemeData? primaryIconTheme,
    ChoiceChipThemeData? choiceChipTheme,
    HeaderThemeData? headerTheme,
    ControlButtonBarThemeData? controlButtonBarTheme,
  }) {
    // Use the given brightness, or a default
    final _brightness = brightness ?? Brightness.light;
    // Determine dark or light
    final isDark = _brightness == Brightness.dark;

    // Use the given primaryIconTheme or a default.
    primaryIconTheme ??= IconThemeData(
      color: isDark ? const Color(0xff959595) : const Color(0xff757575),
    );

    choiceChipTheme = choiceChipTheme ?? ChoiceChipThemeData.light(context);

    headerTheme = headerTheme ?? HeaderThemeData.light(context);

    controlButtonBarTheme =
        controlButtonBarTheme ?? ControlButtonBarThemeData.light(context);

    return FilterListThemeData.raw(
      brightness: _brightness,
      primaryIconTheme: primaryIconTheme,
      choiceChipTheme: choiceChipTheme,
      headerTheme: headerTheme,
      controlBarButtonTheme: controlButtonBarTheme,
    );
  }

  /// A default light theme.
  factory FilterListThemeData.light(BuildContext context) =>
      FilterListThemeData(brightness: Brightness.light, context: context);

  /// A default dark theme.
  factory FilterListThemeData.dark(BuildContext context) =>
      FilterListThemeData(brightness: Brightness.dark, context: context);

  /// Raw [FilterListThemeData] initialization.
  const FilterListThemeData.raw(
      {required this.brightness,
      required this.primaryIconTheme,
      required this.choiceChipTheme,
      required this.headerTheme,
      required this.controlBarButtonTheme});

  /// The [Brightness] of this theme.
  final Brightness brightness;

  /// The primary icon theme
  final IconThemeData primaryIconTheme;

  /// {@macro choice_chip_theme}
  final ChoiceChipThemeData choiceChipTheme;

  /// {@macro header_theme}
  final HeaderThemeData headerTheme;

  /// {@macro control_button_theme}
  final ControlButtonBarThemeData controlBarButtonTheme;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<Brightness>('brightness', brightness))
      ..add(DiagnosticsProperty<IconThemeData>(
          'primaryIconTheme', primaryIconTheme))
      ..add(DiagnosticsProperty<ChoiceChipThemeData>(
          'choiceChipTheme', choiceChipTheme))
      ..add(DiagnosticsProperty<HeaderThemeData>('headerTheme', headerTheme))
      ..add(DiagnosticsProperty<ControlButtonBarThemeData>(
          'controlBarButtonTheme', controlBarButtonTheme));
  }
}
