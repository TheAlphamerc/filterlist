import 'package:flutter/material.dart';
import 'typedefs.dart';

/// Configuration class for filter UI options
class FilterUIConfig {
  /// Whether to hide the header section
  final bool hideHeader;

  /// Whether to hide the search field
  final bool hideSearchField;

  /// Whether to hide the close icon
  final bool hideCloseIcon;

  /// Widget to use as a custom close icon
  final Widget? closeIcon;

  /// Function to execute when close icon is pressed
  final VoidCallback? onClosePressed;

  /// Whether to hide the selected items count
  final bool hideSelectedTextCount;

  /// Text to display as the headline
  final String? headlineText;

  /// Hint text for the search field
  final String? searchFieldHint;

  /// Background color of the filter UI
  final Color backgroundColor;

  /// Whether to enable only single selection mode
  final bool enableOnlySingleSelection;

  /// Text for the Apply button
  final String applyButtonText;

  /// Text for the Reset button
  final String resetButtonText;

  /// Text for the All button
  final String allButtonText;

  /// Text to display for the selected items count
  final String selectedItemsText;

  /// Control buttons to display
  final List<ControlButtonType> controlButtons;

  /// Creates a new FilterUIConfig instance
  const FilterUIConfig({
    this.hideHeader = false,
    this.hideSearchField = false,
    this.hideCloseIcon = false,
    this.closeIcon,
    this.onClosePressed,
    this.hideSelectedTextCount = false,
    this.headlineText,
    this.searchFieldHint,
    this.backgroundColor = Colors.white,
    this.enableOnlySingleSelection = false,
    this.applyButtonText = 'Apply',
    this.resetButtonText = 'Reset',
    this.allButtonText = 'All',
    this.selectedItemsText = 'selected items',
    this.controlButtons = const [
      ControlButtonType.All,
      ControlButtonType.Reset,
      ControlButtonType.Apply,
    ],
  });

  /// Creates a copy of this object with the given fields replaced with new values
  FilterUIConfig copyWith({
    bool? hideHeader,
    bool? hideSearchField,
    bool? hideCloseIcon,
    Widget? closeIcon,
    VoidCallback? onClosePressed,
    bool? hideSelectedTextCount,
    String? headlineText,
    String? searchFieldHint,
    Color? backgroundColor,
    bool? enableOnlySingleSelection,
    String? applyButtonText,
    String? resetButtonText,
    String? allButtonText,
    String? selectedItemsText,
    List<ControlButtonType>? controlButtons,
  }) {
    return FilterUIConfig(
      hideHeader: hideHeader ?? this.hideHeader,
      hideSearchField: hideSearchField ?? this.hideSearchField,
      hideCloseIcon: hideCloseIcon ?? this.hideCloseIcon,
      closeIcon: closeIcon ?? this.closeIcon,
      onClosePressed: onClosePressed ?? this.onClosePressed,
      hideSelectedTextCount:
          hideSelectedTextCount ?? this.hideSelectedTextCount,
      headlineText: headlineText ?? this.headlineText,
      searchFieldHint: searchFieldHint ?? this.searchFieldHint,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      enableOnlySingleSelection:
          enableOnlySingleSelection ?? this.enableOnlySingleSelection,
      applyButtonText: applyButtonText ?? this.applyButtonText,
      resetButtonText: resetButtonText ?? this.resetButtonText,
      allButtonText: allButtonText ?? this.allButtonText,
      selectedItemsText: selectedItemsText ?? this.selectedItemsText,
      controlButtons: controlButtons ?? this.controlButtons,
    );
  }
}
