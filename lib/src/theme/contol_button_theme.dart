import 'package:filter_list/src/theme/filter_list_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'control_button_bar_theme.dart';

/// Overrides the default style of [ContorlButton]
///
/// See also:
///
///  * [ControlButtonThemeData], which is used to configure this theme.
class ControlButtonTheme extends InheritedTheme {
  /// Builds a [GifDialogTheme].
  const ControlButtonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// The configuration of this theme.
  final ControlButtonThemeData data;

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [ControlButtonTheme] widget, then
  /// [FilterListThemeData.controlButtonTheme] is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// final theme = ControlButtonThemeData.of(context);
  /// ```
  static ControlButtonThemeData of(BuildContext context) {
    final controlButtonTheme =
        context.dependOnInheritedWidgetOfExactType<ControlButtonTheme>();
    return controlButtonTheme?.data ??
        ControlButtonBarTheme.of(context).controlButtonTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) =>
      ControlButtonTheme(data: data, child: child);

  @override
  bool updateShouldNotify(ControlButtonTheme oldWidget) =>
      data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ControlButtonThemeData>('data', data));
  }
}

/// {@template control_button_theme_data}
/// A style that overrides the default appearance of [ContorlButton] and
/// [ContorlButton] widgets when used with [ControlButtonTheme] or with the overall
/// [ControlButtonBarTheme]'s [ControlButtonBarThemeData.controlButtonTheme].
///
/// See also:
///
/// * [ControlButtonTheme], the theme which is configured with this class.
/// * [ControlButtonBarThemeData.controlButtonTheme], which can be used to override
/// the default style for [ContorlButton]
/// {@endtemplate}
class ControlButtonThemeData with Diagnosticable {
  /// Builds a [ControlButtonThemeData].
  const ControlButtonThemeData({
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.black87),
    this.primaryButtonTextStyle =
        const TextStyle(fontSize: 16, color: Colors.white),
    this.primaryButtonBackgroundColor = const Color(0xFF84B0F1),
    this.backgroundColor,
    this.borderRadius = 25,
    this.boxShadow,
    this.elevation,
    this.padding: EdgeInsets.zero,
  });

  factory ControlButtonThemeData.light(BuildContext context) =>
      ControlButtonThemeData(
        padding: EdgeInsets.zero,
        textStyle: TextStyle(fontSize: 16, color: Colors.black87),
        primaryButtonTextStyle: TextStyle(fontSize: 16, color: Colors.white),
        primaryButtonBackgroundColor: Color(0xFF84B0F1),
        backgroundColor: Colors.white,
        borderRadius: 40,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 15,
            color: Color(0x12000000),
          )
        ],
        elevation: 0,
      );

  /// Control button elevation
  final double? elevation;

  /// Control button border radius
  final double borderRadius;

  /// TextStyle for control button text.
  final TextStyle? textStyle;

  /// TextStyle for primary control button text.
  final TextStyle? primaryButtonTextStyle;

  /// The background color of the primary button.
  ///
  /// The default is Ligt blue.
  final Color primaryButtonBackgroundColor;

  /// Background color of the control button.
  ///
  /// The default is [Colors.white].
  final Color? backgroundColor;

  /// The box shadow of contrl button.
  final List<BoxShadow>? boxShadow;

  /// The padding of control button.
  final EdgeInsetsGeometry? padding;

  /// Creates a copy of this theme, but with the given fields replaced with
  /// the new values.
  ControlButtonThemeData copyWith({
    Color? shadowColor,
    List<BoxShadow>? boxShadow,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? primaryButtonBackgroundColor,
    double? elevation,
    double? borderRadius,
    TextStyle? primaryButtonTextStyle,
  }) {
    return ControlButtonThemeData(
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      primaryButtonTextStyle:
          primaryButtonTextStyle ?? this.primaryButtonTextStyle,
      primaryButtonBackgroundColor:
          primaryButtonBackgroundColor ?? this.primaryButtonBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      boxShadow: boxShadow ?? this.boxShadow,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
    );
  }

  /// Linearly interpolates between two [ControlButtonThemeData].
  ///
  /// All the properties must be non-null.
  ControlButtonThemeData lerp(
    ControlButtonThemeData a,
    ControlButtonThemeData b,
    double t,
  ) {
    return ControlButtonThemeData(
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t),
      primaryButtonTextStyle:
          TextStyle.lerp(a.primaryButtonTextStyle, b.primaryButtonTextStyle, t),
      primaryButtonBackgroundColor: Color.lerp(
          a.primaryButtonBackgroundColor, b.primaryButtonBackgroundColor, t)!,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      borderRadius: borderRadius,
      boxShadow: a.boxShadow,
      elevation: a.elevation,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ControlButtonThemeData &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          primaryButtonTextStyle == other.primaryButtonTextStyle &&
          primaryButtonBackgroundColor == other.primaryButtonBackgroundColor &&
          boxShadow == other.boxShadow &&
          backgroundColor == other.backgroundColor &&
          elevation == other.elevation &&
          borderRadius == other.borderRadius &&
          padding == other.padding;

  @override
  int get hashCode =>
      textStyle.hashCode ^
      primaryButtonTextStyle.hashCode ^
      primaryButtonBackgroundColor.hashCode ^
      boxShadow.hashCode ^
      backgroundColor.hashCode ^
      elevation.hashCode ^
      borderRadius.hashCode ^
      padding.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle?>(
        'primaryButtonTextStyle', primaryButtonTextStyle));
    properties.add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle));
    properties
        .add(DiagnosticsProperty<List<BoxShadow>>('boxShadow', boxShadow));
    properties.add(DiagnosticsProperty<double>('elevation', elevation));

    properties
        .add(DiagnosticsProperty<Color>('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty<double>('borderRadius', borderRadius));
    properties.add(DiagnosticsProperty<Color>(
        'primaryButtonBackgroundColor', primaryButtonBackgroundColor));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
  }
}
