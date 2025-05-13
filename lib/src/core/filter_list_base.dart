import 'package:filter_list/src/core/filter_callbacks.dart';
import 'package:filter_list/src/core/filter_core.dart';
import 'package:filter_list/src/core/filter_ui_config.dart';
import 'package:flutter/material.dart';

/// Base class for filter list implementations with common functionality
/// shared between FilterListDialog and FilterListDelegate
abstract class FilterListBase {
  /// Creates a FilterCore instance from the provided parameters.
  ///
  /// This utility method is used by both FilterListDialog and FilterListDelegate
  /// to create a consistent core filtering implementation.
  static FilterCore<T> createFilterCore<T>({
    required List<T> allItems,
    List<T>? selectedItems,
    required SearchPredict<T> searchPredicate,
    required ValidateSelectedItem<T> validateSelection,
    ValidateRemoveItem<T>? validateRemoveItem,
    OnApplyButtonClick<T>? onApplyButtonClick,
    int? maximumSelectionLength,
  }) {
    return FilterCore<T>(
      allItems: allItems,
      selectedItems: selectedItems,
      searchPredicate: searchPredicate,
      validateSelection: validateSelection,
      validateRemoveItem: validateRemoveItem,
      onApplyButtonClick: onApplyButtonClick,
      maximumSelectionLength: maximumSelectionLength,
    );
  }

  /// Creates a FilterUIConfig from the provided parameters.
  ///
  /// This utility method ensures consistent UI configuration between
  /// different filter list implementations.
  static FilterUIConfig createUIConfig({
    String? headlineText,
    String? searchFieldHint,
    bool hideSelectedTextCount = false,
    bool hideSearchField = false,
    bool hideHeader = false,
    bool hideCloseIcon = false,
    Widget? closeIcon,
    VoidCallback? onClosePressed,
    bool enableOnlySingleSelection = false,
    String applyButtonText = 'Apply',
    String resetButtonText = 'Reset',
    String allButtonText = 'All',
    String selectedItemsText = 'selected items',
    List<ControlButtonType> controlButtons = const [
      ControlButtonType.all,
      ControlButtonType.reset,
      ControlButtonType.apply
    ],
  }) {
    return FilterUIConfig(
      headlineText: headlineText,
      searchFieldHint: searchFieldHint,
      hideSelectedTextCount: hideSelectedTextCount,
      hideSearchField: hideSearchField,
      hideHeader: hideHeader,
      hideCloseIcon: hideCloseIcon,
      closeIcon: closeIcon,
      onClosePressed: onClosePressed,
      enableOnlySingleSelection: enableOnlySingleSelection,
      applyButtonText: applyButtonText,
      resetButtonText: resetButtonText,
      allButtonText: allButtonText,
      selectedItemsText: selectedItemsText,
      controlButtons: controlButtons,
    );
  }

  /// Creates FilterCallbacks from the provided parameters.
  ///
  /// This utility method ensures consistent callback handling between
  /// different filter list implementations.
  static FilterCallbacks<T> createCallbacks<T>({
    required SearchPredict<T> searchPredicate,
    required LabelDelegate<T> labelProvider,
    required ValidateSelectedItem<T> validateSelection,
    ValidateRemoveItem<T>? validateRemoveItem,
    required OnApplyButtonClick<T> onApplyButtonClick,
  }) {
    return FilterCallbacks<T>(
      searchPredicate: searchPredicate,
      labelProvider: labelProvider,
      validateSelection: validateSelection,
      validateRemoveItem: validateRemoveItem,
      onApplyButtonClick: onApplyButtonClick,
    );
  }
}
