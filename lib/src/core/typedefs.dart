import 'package:flutter/material.dart';

/// A function type for validating if an item is selected
typedef ValidateSelectedItem<T> = bool Function(List<T>? list, T item);

/// A function type for handling removal of items
typedef ValidateRemoveItem<T> = List<T> Function(List<T>? list, T item);

/// A function type that determines if an item matches a search query
typedef SearchPredict<T> = bool Function(T item, String query);

/// A function type that provides a label for an item
typedef LabelDelegate<T> = String? Function(T?);

/// A function type for handling apply button clicks
typedef OnApplyButtonClick<T> = void Function(List<T>? list);

/// A builder for custom choice chips
typedef ChoiceChipBuilder<T> = Widget Function(
    BuildContext context, T? item, bool? isSelected);

/// Control button types used in the filter list UI
enum ControlButtonType {
  /// The All button that selects all items.
  all,

  /// The Reset button that clears all selections.
  reset,

  /// The Apply button that confirms selections and closes the dialog.
  apply
}
