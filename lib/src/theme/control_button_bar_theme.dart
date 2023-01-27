import 'package:filter_list/src/theme/contol_button_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Overrides the default style of [ControlButtonBar]
///
/// See also:
///
///  * [ControlButtonBarThemeData], which is used to configure this theme.
class ControlButtonBarTheme extends InheritedWidget {
  const ControlButtonBarTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// The configuration of this theme.
  final ControlButtonBarThemeData data;

  @override
  bool updateShouldNotify(ControlButtonBarTheme oldWidget) =>
      data != oldWidget.data;

  /// Retrieves the [ControlButtonBarThemeData] from the closest ancestor
  static ControlButtonBarThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<ControlButtonBarTheme>();

    assert(
      theme != null,
      'You must have a ControlButtonBarTheme widget at the top of your widget tree',
    );

    return theme!.data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<ControlButtonBarThemeData>('data', data));
  }
}

/// {@template control_Button_theme_data}
/// A style that overrides the default appearance of [ControlButtonBar] and
/// [ControlButtonBar] widgets when used with [ControlButtonBarTheme] or with the overall
/// {@endtemplate}
class ControlButtonBarThemeData with Diagnosticable {
  factory ControlButtonBarThemeData(
    BuildContext context, {
    double? height,
    double? buttonSpacing,
    BoxDecoration? decoration,
    ControlButtonThemeData? controlButtonTheme,
    Color? backgroundColor,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    controlButtonTheme ??= ControlButtonThemeData.light(context);
    height ??= 50;
    margin ??= const EdgeInsets.symmetric(horizontal: 10, vertical: 10);
    padding ??= const EdgeInsets.symmetric(horizontal: 10);
    buttonSpacing ??= 0;
    // backgroundColor ??= decoration == null ? Colors.white : null;
    if (decoration == null) {
      backgroundColor ??= Colors.white;
    }
    decoration ??= const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(0, 5),
          blurRadius: 15,
          color: Color(0x27000000),
        )
      ],
    );
    return ControlButtonBarThemeData.raw(
      backgroundColor: backgroundColor,
      controlButtonTheme: controlButtonTheme,
      buttonSpacing: buttonSpacing,
      controlContainerDecoration: decoration,
      margin: margin,
      padding: padding,
      height: height,
    );
  }

  /// Builds a [ControlButtonBarThemeData].
  const ControlButtonBarThemeData.raw({
    required this.controlButtonTheme,
    this.buttonSpacing = 0,
    this.height = 50,
    this.margin = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.backgroundColor,
    this.controlContainerDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(0, 5),
          blurRadius: 15,
          color: Color(0x12000000),
        )
      ],
    ),
  });

  factory ControlButtonBarThemeData.light(BuildContext context) =>
      ControlButtonBarThemeData(
        context,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        buttonSpacing: 0,
        height: 50,
        controlButtonTheme: ControlButtonThemeData.light(context),
        backgroundColor: Colors.white,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 15,
              color: Color(0x12000000),
            )
          ],
        ),
      );

  factory ControlButtonBarThemeData.dark(BuildContext context) =>
      ControlButtonBarThemeData(
        context,
        buttonSpacing: 20,
        decoration: BoxDecoration(
          color: const Color(0xff25272C),
          borderRadius: BorderRadius.circular(50),
        ),
        controlButtonTheme: ControlButtonThemeData.dark(context),
        backgroundColor: const Color(0xff25272C),
      );

  /// {@template control_container_decoration}
  /// The box decoration of the control button bar container.
  /// ``` dart
  ///  const BoxDecoration(
  ///   color: Colors.white,
  ///   borderRadius: BorderRadius.all(Radius.circular(25)),
  ///   boxShadow: <BoxShadow>[
  ///     BoxShadow(
  ///       offset: Offset(0, 5),
  ///       blurRadius: 15,
  ///       color: Color(0x12000000),
  ///     )
  ///   ],
  /// ),
  /// ```
  /// {@endtemplate}
  final BoxDecoration? controlContainerDecoration;

  /// Theme for control button
  final ControlButtonThemeData controlButtonTheme;

  /// The spacing between the control buttons.
  final double? buttonSpacing;

  /// Margin of control button bar
  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  /// Height of the control button bar
  final double height;

  /// Background of the control button bar
  final Color? backgroundColor;

  ControlButtonBarThemeData copyWith({
    double? buttonSpacing,
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    BoxDecoration? controlContainerDecoration,
    ControlButtonThemeData? controlButtonTheme,
  }) {
    return ControlButtonBarThemeData.raw(
      controlButtonTheme: controlButtonTheme ?? this.controlButtonTheme,
      buttonSpacing: buttonSpacing ?? this.buttonSpacing,
      height: height ?? this.height,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      controlContainerDecoration:
          controlContainerDecoration ?? this.controlContainerDecoration,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ControlButtonBarThemeData &&
          runtimeType == other.runtimeType &&
          controlContainerDecoration == other.controlContainerDecoration &&
          buttonSpacing == other.buttonSpacing &&
          backgroundColor == other.backgroundColor &&
          controlButtonTheme == other.controlButtonTheme &&
          margin == other.margin &&
          padding == other.padding &&
          height == other.height;

  @override
  int get hashCode =>
      controlContainerDecoration.hashCode ^
      buttonSpacing.hashCode ^
      backgroundColor.hashCode ^
      controlButtonTheme.hashCode ^
      controlContainerDecoration.hashCode ^
      margin.hashCode ^
      padding.hashCode ^
      height.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BoxDecoration>(
        'controlContainerDecoration', controlContainerDecoration));
    properties
        .add(DiagnosticsProperty<Color>('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty<ControlButtonThemeData>(
        'controlButtonTheme', controlButtonTheme));
    properties.add(DiagnosticsProperty<double>('buttonSpacing', buttonSpacing));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
    properties.add(DiagnosticsProperty<double>('height', height));
  }
}
