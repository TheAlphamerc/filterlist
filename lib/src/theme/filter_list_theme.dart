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
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  /// The [FilterListThemeData] styling for this theme.
  final FilterListThemeData theme;

  @override
  bool updateShouldNotify(FilterListTheme oldWidget) =>
      theme != oldWidget.theme;

  /// Retrieves the [FilterListThemeData] from the closest ancestor
  /// [FilterListTheme] widget.
  static FilterListThemeData of(BuildContext context) {
    final FilterListTheme? theme =
        context.dependOnInheritedWidgetOfExactType<FilterListTheme>();
    assert(
      theme != null,
      'You must have a FilterListTheme widget at the top of your widget tree',
    );

    return theme!.theme;
  }
}

/// Defines the configuration of the overall visual [FilterListTheme] for a
/// particular widget subtree.
class FilterListThemeData with Diagnosticable {
  /// Builds a [FilterListThemeData] with default values, if none are given.
  factory FilterListThemeData(
    BuildContext context, {
    // Brightness? brightness,
    ChoiceChipThemeData? choiceChipTheme,
    HeaderThemeData? headerTheme,
    ControlButtonBarThemeData? controlButtonBarTheme,
    double? borderRadius,
    WrapAlignment? wrapAlignment,
    WrapCrossAlignment? wrapCrossAxisAlignment,
    double? wrapSpacing,
    Color? backgroundColor,
  }) {
    // Use the given brightness, or a default
    // final _brightness = brightness ?? Brightness.light;
    // Determine dark or light
    // final isDark = _brightness == Brightness.dark;

    choiceChipTheme = choiceChipTheme ?? ChoiceChipThemeData.light(context);

    headerTheme = headerTheme ?? HeaderThemeData.light();

    controlButtonBarTheme =
        controlButtonBarTheme ?? ControlButtonBarThemeData.light(context);

    /// Border radius of filter dialog
    borderRadius ??= 20;

    /// Background color of filter dialog
    backgroundColor ??= Colors.white;

    /// Wrap alignment of filter dialog
    wrapAlignment ??= WrapAlignment.start;

    /// Wrap cross alignment of filter dialog
    wrapCrossAxisAlignment ??= WrapCrossAlignment.start;

    /// Wrap spacing of filter dialog
    wrapSpacing ??= 0.0;

    return FilterListThemeData.raw(
      // brightness: _brightness,
      choiceChipTheme: choiceChipTheme,
      headerTheme: headerTheme,
      controlBarButtonTheme: controlButtonBarTheme,
      borderRadius: borderRadius,
      wrapAlignment: wrapAlignment,
      wrapCrossAxisAlignment: wrapCrossAxisAlignment,
      wrapSpacing: wrapSpacing,
      backgroundColor: backgroundColor,
    );
  }

  /// A default light theme.
  factory FilterListThemeData.light(BuildContext context) =>
      FilterListThemeData(context);

  factory FilterListThemeData.dark(BuildContext context) {
    return FilterListThemeData(
      context,
      backgroundColor: const Color(0xff141519),
      headerTheme: HeaderThemeData.dark(),
      choiceChipTheme: ChoiceChipThemeData.dark(context),
      controlButtonBarTheme: ControlButtonBarThemeData.dark(context),
      borderRadius: 20,
      wrapAlignment: WrapAlignment.start,
      wrapCrossAxisAlignment: WrapCrossAlignment.start,
      wrapSpacing: 0.0,
    );
  }

  /// Raw [FilterListThemeData] initialization.
  const FilterListThemeData.raw({
    // required this.brightness,
    required this.choiceChipTheme,
    required this.headerTheme,
    required this.controlBarButtonTheme,
    required this.borderRadius,
    required this.wrapAlignment,
    required this.wrapCrossAxisAlignment,
    required this.wrapSpacing,
    required this.backgroundColor,
  });

  // /// The [Brightness] of this theme.
  // final Brightness brightness;

  /// Border radius of the filter dialog
  final double borderRadius;

  /// How the choice chip within a run should be placed in the main axis.
  /// For example, if [wrapSpacing] is [WrapAlignment.center], the choice chip in each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  final WrapAlignment wrapAlignment;

  /// How the choice chip within a run should be aligned relative to each other in the cross axis.
  ///For example, if this is set to [WrapCrossAlignment.end], and the [direction] is [Axis.horizontal], then the choice chip within each run will have their bottom edges aligned to the bottom edge of the run.
  ///
  ///Defaults to [WrapCrossAlignment.start].
  final WrapCrossAlignment wrapCrossAxisAlignment;

  ///How much space to place between choice chip in a run in the main axis.
  ///For example, if [wrapSpacing] is 10.0, the choice chip will be spaced at least 10.0 logical pixels apart in the main axis.
  ///If there is additional free space in a run (e.g., because the wrap has a minimum size that is not filled or because some runs are longer than others), the additional free space will be allocated according to the [alignment].
  ///
  ///Defaults to 0.0.
  final double wrapSpacing;

  /// Background color of the filter list
  final Color? backgroundColor;

  /// {@macro choice_chip_theme}
  final ChoiceChipThemeData choiceChipTheme;

  /// {@macro header_theme}
  final HeaderThemeData headerTheme;

  /// {@macro control_button_theme}
  final ControlButtonBarThemeData controlBarButtonTheme;

  FilterListThemeData copyWith({
    Brightness? brightness,
    ChoiceChipThemeData? choiceChipTheme,
    HeaderThemeData? headerTheme,
    ControlButtonBarThemeData? controlBarButtonTheme,
    double? borderRadius,
    WrapAlignment? wrapAlignment,
    WrapCrossAlignment? wrapCrossAxisAlignment,
    double? wrapSpacing,
    Color? backgroundColor,
  }) {
    return FilterListThemeData.raw(
      choiceChipTheme: choiceChipTheme ?? this.choiceChipTheme,
      headerTheme: headerTheme ?? this.headerTheme,
      controlBarButtonTheme:
          controlBarButtonTheme ?? this.controlBarButtonTheme,
      borderRadius: borderRadius ?? this.borderRadius,
      wrapAlignment: wrapAlignment ?? this.wrapAlignment,
      wrapCrossAxisAlignment:
          wrapCrossAxisAlignment ?? this.wrapCrossAxisAlignment,
      wrapSpacing: wrapSpacing ?? this.wrapSpacing,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  FilterListThemeData lerp(
      FilterListThemeData a, FilterListThemeData b, double t) {
    return FilterListThemeData.raw(
      // brightness: t < 0.5 ? other.brightness : brightness,
      choiceChipTheme: choiceChipTheme,
      headerTheme: headerTheme,
      controlBarButtonTheme: controlBarButtonTheme,
      borderRadius: a.borderRadius,
      wrapAlignment: a.wrapAlignment,
      wrapCrossAxisAlignment: a.wrapCrossAxisAlignment,
      wrapSpacing: a.wrapSpacing,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      // ..add(EnumProperty<Brightness>('brightness', brightness))
      ..add(DiagnosticsProperty<double>('borderRadius', borderRadius))
      ..add(DiagnosticsProperty<Color>('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty<ChoiceChipThemeData>(
          'choiceChipTheme', choiceChipTheme))
      ..add(DiagnosticsProperty<HeaderThemeData>('headerTheme', headerTheme))
      ..add(DiagnosticsProperty<ControlButtonBarThemeData>(
          'controlButtonBarTheme', controlBarButtonTheme))
      ..add(DiagnosticsProperty<WrapAlignment>('wrapAlignment', wrapAlignment))
      ..add(DiagnosticsProperty<WrapCrossAlignment>(
          'wrapCrossAxisAlignment', wrapCrossAxisAlignment))
      ..add(DiagnosticsProperty<double>('wrapSpacing', wrapSpacing))
      ..add(DiagnosticsProperty<ChoiceChipThemeData>(
          'choiceChipTheme', choiceChipTheme))
      ..add(DiagnosticsProperty<HeaderThemeData>('headerTheme', headerTheme))
      ..add(DiagnosticsProperty<ControlButtonBarThemeData>(
          'controlBarButtonTheme', controlBarButtonTheme));
  }
}
