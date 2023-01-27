import 'package:filter_list/src/theme/filter_list_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Overrides the default style of [ChoiceChip]
///
/// See also:
///
///  * [HeaderThemeData], which is used to configure this theme.
class HeaderTheme extends InheritedTheme {
  /// Builds a [GifDialogTheme].
  const HeaderTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// The configuration of this theme.
  final HeaderThemeData data;

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [HeaderTheme] widget, then
  /// [FilterListThemeData.choiceChipTheme] is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// final theme = HeaderThemeData.of(context);
  /// ```
  static HeaderThemeData of(BuildContext context) {
    final choiceChipTheme =
        context.dependOnInheritedWidgetOfExactType<HeaderTheme>();
    return choiceChipTheme?.data ?? FilterListTheme.of(context).headerTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) =>
      HeaderTheme(data: data, child: child);

  @override
  bool updateShouldNotify(HeaderTheme oldWidget) => data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<HeaderThemeData>('data', data));
  }
}

/// {@template choice_chip_theme}
/// A style that overrides the default appearance of [ChoiceChip] and
/// [ChoiceChip] widgets when used with [HeaderTheme] or with the overall
/// [FilterListTheme]'s [FilterListThemeData.choiceChipTheme].
///
/// See also:
///
/// * [HeaderTheme], the theme which is configured with this class.
/// * [FilterListThemeData.choiceChipTheme], which can be used to override
/// the default style for [ChoiceChip]
/// {@endtemplate}
class HeaderThemeData with Diagnosticable {
  /// Builds a [HeaderThemeData].
  const HeaderThemeData({
    this.headerTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black54,
      fontWeight: FontWeight.bold,
    ),
    this.searchFieldTextStyle,
    this.searchFieldBackgroundColor = const Color(0xfff5f5f5),
    this.closeIconColor = Colors.black54,
    this.searchFieldIconColor = Colors.black54,
    this.backgroundColor,
    this.searchFieldInputBorder = InputBorder.none,
    this.boxShadow,
    this.searchFieldBorderRadius = 100,
    this.searchFieldHintText = 'Search here...',
    this.searchFieldHintTextStyle,
  });

  factory HeaderThemeData.light() => const HeaderThemeData(
        searchFieldTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
        backgroundColor: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 15,
            color: Color(0x12000000),
          )
        ],
      );
  factory HeaderThemeData.dark() {
    return const HeaderThemeData(
      backgroundColor: Color(0xff25272C),
      searchFieldBackgroundColor: Color(0xff25272C),
      searchFieldHintTextStyle: TextStyle(color: Color(0xff8A9AAA)),
      searchFieldIconColor: Color(0xff8A9AAA),
      searchFieldTextStyle: TextStyle(color: Color(0xff8A9AAA)),
      headerTextStyle: TextStyle(color: Color(0xff8A9AAA), fontSize: 18),
      closeIconColor: Color(0xff8A9AAA),
    );
  }

  /// TextStyle for the header text.
  final TextStyle? headerTextStyle;

  /// TextStyle for the search field text.
  final TextStyle? searchFieldTextStyle;

  /// Background color of the search field.
  ///
  /// The default is [Colors.blue].
  final Color? searchFieldBackgroundColor;

  /// The color for the close icon.
  ///
  /// The default is black.
  final Color closeIconColor;

  /// The search icon color for the search field.
  final Color? searchFieldIconColor;

  /// Background color of the header.
  ///
  /// The default is [Colors.white].
  final Color? backgroundColor;

  /// Border radius of the search field.
  /// Defaults to 100. The value is always non-negative.
  final double searchFieldBorderRadius;

  /// Defines the appearance of an search field input border.
  ///
  /// An input decorator's border is specified by [InputDecoration.border].
  final InputBorder? searchFieldInputBorder;

  ///Create box shadow for the header.
  final List<BoxShadow>? boxShadow;

  /// Search field hint text
  ///
  /// The default is "Search here..."
  final String? searchFieldHintText;

  /// The [TextStyle] for search field hint text
  final TextStyle? searchFieldHintTextStyle;

  /// Creates a copy of this theme, but with the given fields replaced with
  /// the new values.
  HeaderThemeData copyWith({
    TextStyle? selectedChipTextStyle,
    TextStyle? unselectedChipTextStyle,
    TextStyle? searchFieldTextStyle,
    TextStyle? headerTextStyle,
    Color? unselectedTextBackgroundColor,
    VisualDensity? visualDensity,
    double? searchFieldBorderRadius,
    String? searchFieldHintText,
    TextStyle? searchFieldHintTextStyle,
    Color? shadowColor,
    Color? selectedShadowColor,
    List<BoxShadow>? boxShadow,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? searchFieldBackgroundColor,
    Color? closeIconColor,
    Color? searchFieldIconColor,
  }) {
    return HeaderThemeData(
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      searchFieldTextStyle: searchFieldTextStyle ?? this.searchFieldTextStyle,
      searchFieldBackgroundColor:
          searchFieldBackgroundColor ?? this.searchFieldBackgroundColor,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      searchFieldIconColor: searchFieldIconColor ?? this.searchFieldIconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      boxShadow: boxShadow ?? this.boxShadow,
      searchFieldBorderRadius:
          searchFieldBorderRadius ?? this.searchFieldBorderRadius,
      searchFieldHintText: searchFieldHintText ?? this.searchFieldHintText,
      searchFieldHintTextStyle:
          searchFieldHintTextStyle ?? this.searchFieldHintTextStyle,
    );
  }

  /// Linearly interpolates between two [HeaderThemeData].
  ///
  /// All the properties must be non-null.
  HeaderThemeData lerp(
    HeaderThemeData a,
    HeaderThemeData b,
    double t,
  ) {
    return HeaderThemeData(
      headerTextStyle: TextStyle.lerp(a.headerTextStyle, b.headerTextStyle, t),
      searchFieldTextStyle:
          TextStyle.lerp(a.searchFieldTextStyle, b.searchFieldTextStyle, t),
      searchFieldBackgroundColor: a.searchFieldBackgroundColor,
      closeIconColor: Color.lerp(a.closeIconColor, b.closeIconColor, t)!,
      searchFieldIconColor:
          Color.lerp(a.searchFieldIconColor, b.searchFieldIconColor, t),
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      boxShadow: a.boxShadow,
      searchFieldBorderRadius: a.searchFieldBorderRadius,
      searchFieldHintText: a.searchFieldHintText,
      searchFieldHintTextStyle: a.searchFieldHintTextStyle,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeaderThemeData &&
          runtimeType == other.runtimeType &&
          headerTextStyle == other.headerTextStyle &&
          searchFieldTextStyle == other.searchFieldTextStyle &&
          searchFieldBackgroundColor == other.searchFieldBackgroundColor &&
          closeIconColor == other.closeIconColor &&
          searchFieldIconColor == other.searchFieldIconColor &&
          boxShadow == other.boxShadow &&
          searchFieldBorderRadius == other.searchFieldBorderRadius &&
          searchFieldHintText == other.searchFieldHintText &&
          searchFieldHintTextStyle == other.searchFieldHintTextStyle &&
          backgroundColor == other.backgroundColor;

  @override
  int get hashCode =>
      headerTextStyle.hashCode ^
      searchFieldTextStyle.hashCode ^
      searchFieldBackgroundColor.hashCode ^
      closeIconColor.hashCode ^
      searchFieldIconColor.hashCode ^
      boxShadow.hashCode ^
      searchFieldBorderRadius.hashCode ^
      searchFieldHintText.hashCode ^
      searchFieldHintTextStyle.hashCode ^
      backgroundColor.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color>(
        'searchFieldBackgroundColor', searchFieldBackgroundColor));
    properties.add(DiagnosticsProperty<TextStyle?>(
        'searchFieldTextStyle', searchFieldTextStyle));
    properties.add(
        DiagnosticsProperty<TextStyle?>('headerTextStyle', headerTextStyle));
    properties
        .add(DiagnosticsProperty<List<BoxShadow>>('boxShadow', boxShadow));
    properties.add(DiagnosticsProperty<double>(
        'searchFieldBorderRadius', searchFieldBorderRadius));
    properties.add(DiagnosticsProperty<String>(
        'searchFieldHintText', searchFieldHintText));
    properties.add(DiagnosticsProperty<TextStyle>(
        'searchFieldHintTextStyle', searchFieldHintTextStyle));
    properties
        .add(DiagnosticsProperty<Color>('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty<Color>(
        'searchFieldIconColor', searchFieldIconColor));
  }
}
