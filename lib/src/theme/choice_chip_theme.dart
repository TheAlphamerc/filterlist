import 'package:filter_list/src/theme/filter_list_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Overrides the default style of [ChoiceChip]
///
/// See also:
///
///  * [ChoiceChipThemeData], which is used to configure this theme.
class ChoiceChipTheme extends InheritedTheme {
  /// Builds a [GifDialogTheme].
  const ChoiceChipTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// The configuration of this theme.
  final ChoiceChipThemeData data;

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [ChoiceChipTheme] widget, then
  /// [FilterListThemeData.choiceChipTheme] is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// final theme = ChoiceChipThemeData.of(context);
  /// ```
  static ChoiceChipThemeData of(BuildContext context) {
    final choiceChipTheme =
        context.dependOnInheritedWidgetOfExactType<ChoiceChipTheme>();
    return choiceChipTheme?.data ?? FilterListTheme.of(context).choiceChipTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) =>
      ChoiceChipTheme(data: data, child: child);

  @override
  bool updateShouldNotify(ChoiceChipTheme oldWidget) => data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ChoiceChipThemeData>('data', data));
  }
}

/// {@template choice_chip_theme}
/// A style that overrides the default appearance of [ChoiceChip] and
/// [ChoiceChip] widgets when used with [ChoiceChipTheme] or with the overall
/// [FilterListTheme]'s [FilterListThemeData.choiceChipTheme].
///
/// See also:
///
/// * [ChoiceChipTheme], the theme which is configured with this class.
/// * [FilterListThemeData.choiceChipTheme], which can be used to override
/// the default style for [ChoiceChip]
/// {@endtemplate}
class ChoiceChipThemeData with Diagnosticable {
  /// Builds a [ChoiceChipThemeData].
  const ChoiceChipThemeData({
    this.selectedTextStyle,
    this.textStyle,
    this.selectedBackgroundColor,
    this.backgroundColor,
    this.visualDensity,
    this.elevation,
    this.side,
    this.selectedSide,
    this.shape,
    this.selectedShape,
    this.shadowColor = Colors.black,
    this.selectedShadowColor = Colors.black,
    this.padding,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0),
  });

  factory ChoiceChipThemeData.light(BuildContext context) =>
      ChoiceChipThemeData(
        selectedTextStyle:
            TextStyle(color: Theme.of(context).colorScheme.primary),
        textStyle: const TextStyle(color: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevation: 0,
        padding: const EdgeInsets.all(4),
        selectedBackgroundColor:
            Theme.of(context).colorScheme.primaryContainer.withOpacity(.2),
      );

  factory ChoiceChipThemeData.dark(BuildContext context) {
    final theme = Theme.of(context);
    final darkTheme = ThemeData.dark();
    return ChoiceChipThemeData(
      backgroundColor: const Color(0xff25272C),
      side: BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.12)),
      textStyle: const TextStyle(color: Color(0xffb0b0c0)),
      selectedTextStyle: TextStyle(color: darkTheme.colorScheme.primary),
      selectedSide: BorderSide(
        color: theme.colorScheme.primaryContainer,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      selectedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      selectedBackgroundColor:
          Theme.of(context).colorScheme.primaryContainer.withOpacity(.2),
    );
  }

  /// TextStyle for chip when selected.
  final TextStyle? selectedTextStyle;

  /// TextStyle for chip when not selected.
  final TextStyle? textStyle;

  /// Color to be used for the selected, selected chip's background.
  ///
  /// The default is [const Color(0xFF649BEC)].
  final Color? selectedBackgroundColor;

  /// Color to be used for the unselected, unselected chip's background.
  ///
  /// The default is light grey.
  final Color? backgroundColor;

  ///Defines how compact the chip's layout will be.
  ///
  /// Chips are unaffected by horizontal density changes.
  final VisualDensity? visualDensity;

  /// Elevation to be applied on the chip relative to its parent.
  ///
  /// This controls the size of the shadow below the chip.
  ///
  /// Defaults to 0. The value is always non-negative.
  final double? elevation;

  /// The color and weight of the chip's outline.
  ///
  /// Defaults to the border side in the ambient [ChipThemeData]. If the theme border side resolves to null, the default is the border side of [shape].
  final BorderSide? side;

  /// The color and weight of the selected chip's outline.
  ///
  /// Defaults to the border side in the ambient [ChipThemeData]. If the theme border side resolves to null, the default is the border side of [shape].
  final BorderSide? selectedSide;

  /// The [OutlinedBorder] to draw around the chip.
  ///
  /// Defaults to the shape in the ambient [ChipThemeData]. If the theme shape resolves to null, the default is [StadiumBorder].
  final OutlinedBorder? shape;

  /// The [OutlinedBorder] to draw around selected the chip.
  final OutlinedBorder? selectedShape;

  /// Color of the chip's shadow when the elevation is greater than 0.
  ///
  /// The default is [Colors.black].
  final Color? shadowColor;

  /// Color of the chip's shadow when the elevation is greater than 0 and the chip is selected.
  ///
  ///The default is [Colors.black].
  final Color? selectedShadowColor;

  /// The padding between the contents of the chip and the outside [shape].
  ///
  /// Defaults to 4 logical pixels on all sides.

  final EdgeInsetsGeometry? padding;

  /// The padding around the [label] widget.
  ///
  /// By default, this is 4 logical pixels at the beginning and the end of the label, and zero on top and bottom.
  final EdgeInsetsGeometry? labelPadding;

  /// The margin around choice chip
  final EdgeInsetsGeometry margin;

  /// Creates a copy of this theme, but with the given fields replaced with
  /// the new values.
  ChoiceChipThemeData copyWith({
    TextStyle? selectedTextStyle,
    TextStyle? selectedChipTextStyle,
    TextStyle? textStyle,
    Color? selectedTextBackgroundColor,
    Color? selectedBackgroundColor,
    Color? backgroundColor,
    VisualDensity? visualDensity,
    double? elevation,
    BorderSide? side,
    BorderSide? selectedSide,
    OutlinedBorder? shape,
    OutlinedBorder? selectedShape,
    Color? shadowColor,
    Color? selectedShadowColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? margin,
    Color? canvasColor,
  }) {
    return ChoiceChipThemeData(
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      textStyle: textStyle ?? textStyle,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      visualDensity: visualDensity ?? this.visualDensity,
      elevation: elevation ?? this.elevation,
      side: side ?? this.side,
      selectedSide: selectedSide ?? this.selectedSide,
      shape: shape ?? this.shape,
      selectedShape: selectedShape ?? this.selectedShape,
      shadowColor: shadowColor ?? this.shadowColor,
      selectedShadowColor: selectedShadowColor ?? this.selectedShadowColor,
      padding: padding ?? this.padding,
      labelPadding: labelPadding ?? this.labelPadding,
      margin: margin ?? this.margin,
    );
  }

  /// Linearly interpolates between two [ChoiceChipThemeData].
  ///
  /// All the properties must be non-null.

  ChoiceChipThemeData lerp(
      ChoiceChipThemeData a, ChoiceChipThemeData b, double t) {
    return ChoiceChipThemeData(
      selectedTextStyle:
          TextStyle.lerp(a.selectedTextStyle, b.selectedTextStyle, t),
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t),
      selectedBackgroundColor:
          Color.lerp(a.selectedBackgroundColor, b.selectedBackgroundColor, t),
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      visualDensity: VisualDensity.lerp(a.visualDensity!, b.visualDensity!, t),
      elevation: b.elevation,
      side: BorderSide.lerp(side!, b.side!, t),
      selectedSide: BorderSide.lerp(a.selectedSide!, b.selectedSide!, t),
      shape: a.shape,
      selectedShape: a.selectedShape,
      shadowColor: Color.lerp(a.shadowColor, b.shadowColor, t),
      selectedShadowColor:
          Color.lerp(selectedShadowColor, b.selectedShadowColor, t),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t),
      labelPadding: EdgeInsetsGeometry.lerp(a.labelPadding, b.labelPadding, t),
      margin: EdgeInsetsGeometry.lerp(a.margin, b.margin, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceChipThemeData &&
          runtimeType == other.runtimeType &&
          selectedTextStyle == other.selectedTextStyle &&
          textStyle == other.textStyle &&
          selectedBackgroundColor == other.selectedBackgroundColor &&
          backgroundColor == other.backgroundColor &&
          visualDensity == other.visualDensity &&
          elevation == other.elevation &&
          side == other.side &&
          selectedSide == other.selectedSide &&
          shape == other.shape &&
          selectedShape == other.selectedShape &&
          shadowColor == other.shadowColor &&
          selectedShadowColor == other.selectedShadowColor &&
          padding == other.padding &&
          labelPadding == other.labelPadding &&
          margin == other.margin;

  @override
  int get hashCode =>
      selectedTextStyle.hashCode ^
      textStyle.hashCode ^
      selectedBackgroundColor.hashCode ^
      backgroundColor.hashCode ^
      visualDensity.hashCode ^
      elevation.hashCode ^
      side.hashCode ^
      selectedSide.hashCode ^
      shape.hashCode ^
      selectedShape.hashCode ^
      shadowColor.hashCode ^
      selectedShadowColor.hashCode ^
      padding.hashCode ^
      labelPadding.hashCode ^
      margin.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color>(
        'selectedTextBackgroundColor', selectedBackgroundColor));
    properties.add(
        DiagnosticsProperty<TextStyle?>('unselectedChipTextStyle', textStyle));
    properties.add(DiagnosticsProperty<TextStyle?>(
        'selectedChipTextStyle', selectedTextStyle));
    properties.add(
        DiagnosticsProperty<VisualDensity>('visualDensity', visualDensity));
    properties.add(DiagnosticsProperty<double>('elevation', elevation));
    properties.add(DiagnosticsProperty<BorderSide>('side', side));
    properties
        .add(DiagnosticsProperty<BorderSide>('selectedSide', selectedSide));
    properties.add(DiagnosticsProperty<OutlinedBorder>('shape', shape));
    properties.add(
        DiagnosticsProperty<OutlinedBorder>('selectedShape', selectedShape));

    properties.add(DiagnosticsProperty<Color>('shadowColor', shadowColor));
    properties.add(
        DiagnosticsProperty<Color>('selectedShadowColor', selectedShadowColor));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
    properties.add(
        DiagnosticsProperty<EdgeInsetsGeometry>('labelPadding', labelPadding));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin));
  }
}
