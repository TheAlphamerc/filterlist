import 'typedefs.dart';

/// A class to hold all callback functions used in filter operations
class FilterCallbacks<T> {
  /// Determines if an item matches a search query
  final SearchPredict<T> searchPredicate;

  /// Provides a label for an item (used in chips, tiles, etc.)
  final LabelDelegate<T> labelProvider;

  /// Validates if an item is selected
  final ValidateSelectedItem<T> validateSelection;

  /// Handles removal of an item (optional)
  final ValidateRemoveItem<T>? validateRemoveItem;

  /// Called when apply button is clicked
  final OnApplyButtonClick<T> onApplyButtonClick;

  /// Creates a new instance of FilterCallbacks
  const FilterCallbacks({
    required this.searchPredicate,
    required this.labelProvider,
    required this.validateSelection,
    required this.onApplyButtonClick,
    this.validateRemoveItem,
  });

  /// Creates a copy of this object with the given fields replaced with new values
  FilterCallbacks<T> copyWith({
    SearchPredict<T>? searchPredicate,
    LabelDelegate<T>? labelProvider,
    ValidateSelectedItem<T>? validateSelection,
    ValidateRemoveItem<T>? validateRemoveItem,
    OnApplyButtonClick<T>? onApplyButtonClick,
  }) {
    return FilterCallbacks<T>(
      searchPredicate: searchPredicate ?? this.searchPredicate,
      labelProvider: labelProvider ?? this.labelProvider,
      validateSelection: validateSelection ?? this.validateSelection,
      validateRemoveItem: validateRemoveItem ?? this.validateRemoveItem,
      onApplyButtonClick: onApplyButtonClick ?? this.onApplyButtonClick,
    );
  }
}
