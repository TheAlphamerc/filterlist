import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilterListDelegateTheme extends InheritedWidget {
  /// Builds a [FilterListDelegateTheme].
  const FilterListDelegateTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final FilterListDelegateThemeData theme;

  @override
  bool updateShouldNotify(FilterListDelegateTheme oldWidget) =>
      theme != oldWidget.theme;

  /// Retrieves the [FilterListDelegateThemeData] from the closest ancestor
  /// [FilterListDelegateTheme] widget.
  static FilterListDelegateThemeData of(BuildContext context) {
    final FilterListDelegateTheme? theme =
        context.dependOnInheritedWidgetOfExactType<FilterListDelegateTheme>();
    assert(
      theme != null,
      'You must have a FilterListDelegateTheme widget at the top of your widget tree',
    );

    return theme!.theme;
  }
}

/// Defines the configuration of the overall visual [FilterListDelegateTheme] for a
/// particular widget subtree.
class FilterListDelegateThemeData with Diagnosticable {
  /// Builds a [FilterListDelegateThemeData] with default values, if none are given.
  factory FilterListDelegateThemeData({
    ListTileThemeData? listTileTheme,
    BoxBorder? tileBorder,
    List<BoxShadow>? tileShadow,
    EdgeInsetsGeometry? tileMargin,
    Color? tileColor,
    TextStyle? tileTextStyle,
  }) {
    tileTextStyle = tileTextStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        );

    listTileTheme ??= const ListTileThemeData();

    tileMargin ??= const EdgeInsets.symmetric(horizontal: 10, vertical: 8);

    return FilterListDelegateThemeData.raw(
      listTileTheme: listTileTheme,
      tileBorder: tileBorder,
      tileShadow: tileShadow,
      tileMargin: tileMargin,
      tileColor: tileColor,
      tileTextStyle: tileTextStyle,
    );
  }

  /// Raw [FilterListDelegateThemeData] initialization.
  const FilterListDelegateThemeData.raw(
      {required this.listTileTheme,
      required this.tileBorder,
      required this.tileShadow,
      required this.tileMargin,
      required this.tileColor,
      required this.tileTextStyle});

  /// TextStyle for tile title
  final TextStyle tileTextStyle;

  final EdgeInsetsGeometry tileMargin;

  /// Defines the background color of ListTile when [selected] is false.
  ///
  /// When the value is null, the tileColor is set to [ListTileTheme.tileColor] if it's not null and to [Colors.transparent] if it's null.
  final Color? tileColor;

  /// {@macro choice_chip_theme}
  final ListTileThemeData listTileTheme;

  /// Defines the border of ListTile
  final BoxBorder? tileBorder;

  /// Defines the shadow of ListTile
  final List<BoxShadow>? tileShadow;

  FilterListDelegateThemeData copyWith({
    ListTileThemeData? listTileTheme,
    BoxBorder? tileBorder,
    List<BoxShadow>? tileShadow,
    EdgeInsetsGeometry? tileMargin,
    Color? tileColor,
    TextStyle? tileTextStyle,
  }) {
    return FilterListDelegateThemeData.raw(
      listTileTheme: listTileTheme ?? this.listTileTheme,
      tileBorder: tileBorder ?? this.tileBorder,
      tileShadow: tileShadow ?? this.tileShadow,
      tileMargin: tileMargin ?? this.tileMargin,
      tileColor: tileColor ?? this.tileColor,
      tileTextStyle: tileTextStyle ?? this.tileTextStyle,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Color>('tileColor', tileColor))
      ..add(DiagnosticsProperty<ListTileThemeData>(
          'listTileTheme', listTileTheme))
      ..add(DiagnosticsProperty<BoxBorder>('tileBorder', tileBorder))
      ..add(DiagnosticsProperty<List<BoxShadow>>('tileShadow', tileShadow))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>('tileMargin', tileMargin))
      ..add(DiagnosticsProperty<ListTileThemeData>(
          'listTileTheme', listTileTheme))
      ..add(DiagnosticsProperty<BoxBorder>('tileBorder', tileBorder));
  }
}
