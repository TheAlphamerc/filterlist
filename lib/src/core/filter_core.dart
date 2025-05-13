import 'package:flutter/material.dart';

// Typedefs moved to a separate file to avoid conflicts
export 'typedefs.dart';

/// Core filtering logic class that centralizes common operations across different
/// filter implementations (dialog, widget, delegate)
class FilterCore<T> {
  /// All available items for filtering
  final List<T>? allItems;

  /// Currently selected items
  List<T>? _selectedItems;

  /// Maximum number of items that can be selected
  final int? maximumSelectionLength;

  /// Function to search items based on a query
  final bool Function(T item, String query) searchPredicate;

  /// Function to validate if an item is selected
  final bool Function(List<T>? list, T item) validateSelection;

  /// Function to handle removal of items
  final List<T> Function(List<T>? list, T item)? validateRemoveItem;

  /// Function to get called when apply button is clicked
  final void Function(List<T>? list)? onApplyButtonClick;

  /// Creates a FilterCore instance
  FilterCore({
    required this.allItems,
    List<T>? selectedItems,
    required this.searchPredicate,
    required this.validateSelection,
    this.validateRemoveItem,
    this.onApplyButtonClick,
    this.maximumSelectionLength,
  }) {
    _selectedItems = selectedItems != null ? List<T>.from(selectedItems) : [];
  }

  /// Get the list of all items
  List<T> get items => allItems != null ? List<T>.from(allItems!) : [];

  /// Get the list of selected items
  List<T> get selectedItems =>
      _selectedItems != null ? List<T>.from(_selectedItems!) : [];

  /// Set the list of selected items
  set selectedItems(List<T> value) {
    _selectedItems = List<T>.from(value);
  }

  /// Get the number of selected items
  int get selectedItemsCount => _selectedItems?.length ?? 0;

  /// Check if an item is selected
  bool isSelected(T item) => validateSelection(_selectedItems, item);

  /// Check if maximum selection is reached
  bool get isMaximumSelectionReached =>
      maximumSelectionLength != null &&
      selectedItemsCount >= maximumSelectionLength!;

  /// Filter items based on a search query
  List<T> performSearch(String query) {
    if (query.isEmpty || allItems == null) return items;

    return allItems!.where((item) => searchPredicate(item, query)).toList();
  }

  /// Add an item to the selected items list
  void addSelectedItem(T item) {
    _selectedItems ??= [];

    if (maximumSelectionLength != null &&
        _selectedItems!.length >= maximumSelectionLength!) {
      return; // Don't add if maximum selection is reached
    }

    if (!_selectedItems!.contains(item)) {
      _selectedItems!.add(item);
    }
  }

  /// Remove an item from the selected items list
  void removeSelectedItem(T item) {
    if (_selectedItems == null) return;

    if (validateRemoveItem != null) {
      _selectedItems = validateRemoveItem!(_selectedItems, item);
    } else {
      _selectedItems!.remove(item);
    }
  }

  /// Toggle selection of an item
  void toggleSelection(T item, {bool enableOnlySingleSelection = false}) {
    if (enableOnlySingleSelection) {
      clearSelectedItems();
      addSelectedItem(item);
    } else {
      if (isSelected(item)) {
        removeSelectedItem(item);
      } else {
        addSelectedItem(item);
      }
    }
  }

  /// Clear all selected items
  void clearSelectedItems() {
    if (_selectedItems == null) return;
    _selectedItems!.clear();
  }

  /// Select all available items
  void selectAllItems() {
    if (allItems == null) return;

    if (maximumSelectionLength != null) {
      // If maximum selection length is set, only add up to that limit
      _selectedItems =
          List<T>.from(allItems!.take(maximumSelectionLength!).toList());
    } else {
      _selectedItems = List<T>.from(allItems!);
    }
  }

  /// Apply the filter and return selected items
  List<T>? applyFilter() {
    if (onApplyButtonClick != null) {
      onApplyButtonClick!(_selectedItems);
    }
    return _selectedItems;
  }
}
