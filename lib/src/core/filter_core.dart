import 'package:flutter/material.dart';

// Typedefs moved to a separate file to avoid conflicts
export 'typedefs.dart';
import 'filter_operations.dart';

/// Core filtering logic class that centralizes common operations across different
/// filter implementations (dialog, widget, delegate)
class FilterCore<T> implements FilterOperations<T> {
  /// All available items for filtering
  final List<T>? _allItems;

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
    required List<T>? allItems,
    List<T>? selectedItems,
    required this.searchPredicate,
    required this.validateSelection,
    this.validateRemoveItem,
    this.onApplyButtonClick,
    this.maximumSelectionLength,
  }) : _allItems = allItems {
    _selectedItems = selectedItems != null ? List<T>.from(selectedItems) : [];
  }

  /// Get the list of all items
  @override
  List<T> get allItems => _allItems != null ? List<T>.from(_allItems!) : [];

  /// Get the list of selected items
  @override
  List<T> get selectedItems =>
      _selectedItems != null ? List<T>.from(_selectedItems!) : [];

  /// Set the list of selected items
  set selectedItems(List<T> value) {
    _selectedItems = List<T>.from(value);
  }

  /// Get the number of selected items
  @override
  int get selectedItemsCount => _selectedItems?.length ?? 0;

  /// Check if an item is selected
  @override
  bool isItemSelected(T item) => validateSelection(_selectedItems, item);

  /// Check if maximum selection is reached
  @override
  bool get isMaximumSelectionReached =>
      maximumSelectionLength != null &&
      selectedItemsCount >= maximumSelectionLength!;

  /// Filter items based on a search query
  @override
  List<T> filter(String query) {
    // Return all items for empty query or null allItems
    if (query.isEmpty || _allItems == null) return allItems;

    return _allItems!.where((item) {
      // Safely handle potential null items or errors in search predicate
      try {
        return searchPredicate(item, query);
      } catch (e) {
        // If an error occurs during search (often due to null values),
        // don't include this item in results
        debugPrint('Error filtering item: $e');
        return false;
      }
    }).toList();
  }

  /// Add an item to the selected items list
  @override
  void addItem(T item) {
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
  @override
  void removeItem(T item) {
    if (_selectedItems == null) return;

    if (validateRemoveItem != null) {
      _selectedItems = validateRemoveItem!(_selectedItems, item);
    } else {
      _selectedItems!.remove(item);
    }
  }

  /// Toggle selection of an item
  @override
  void toggleItem(T item, {bool enableOnlySingleSelection = false}) {
    if (enableOnlySingleSelection) {
      clearSelection();
      addItem(item);
    } else {
      if (isItemSelected(item)) {
        removeItem(item);
      } else {
        addItem(item);
      }
    }
  }

  /// Clear all selected items
  @override
  void clearSelection() {
    if (_selectedItems == null) return;
    _selectedItems!.clear();
  }

  /// Select all available items
  @override
  void selectAll() {
    if (_allItems == null) return;

    if (maximumSelectionLength != null) {
      // If maximum selection length is set, only add up to that limit
      _selectedItems = _allItems!.take(maximumSelectionLength!).toList();
    } else {
      _selectedItems = List<T>.from(_allItems!);
    }
  }

  /// Apply the filter and return selected items
  @override
  List<T>? applyFilter() {
    if (onApplyButtonClick != null) {
      onApplyButtonClick!(_selectedItems);
    }
    return _selectedItems;
  }

  // Legacy method names to maintain backward compatibility

  /// @deprecated Use [isItemSelected] instead
  bool isSelected(T item) => isItemSelected(item);

  /// @deprecated Use [filter] instead
  List<T> performSearch(String query) => filter(query);

  /// @deprecated Use [addItem] instead
  void addSelectedItem(T item) => addItem(item);

  /// @deprecated Use [removeItem] instead
  void removeSelectedItem(T item) => removeItem(item);

  /// @deprecated Use [toggleItem] instead
  void toggleSelection(T item, {bool enableOnlySingleSelection = false}) =>
      toggleItem(item, enableOnlySingleSelection: enableOnlySingleSelection);

  /// @deprecated Use [clearSelection] instead
  void clearSelectedItems() => clearSelection();

  /// @deprecated Use [selectAll] instead
  void selectAllItems() => selectAll();
}
