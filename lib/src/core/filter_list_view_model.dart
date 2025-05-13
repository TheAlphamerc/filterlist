import 'package:flutter/material.dart';
import 'filter_callbacks.dart';
import 'filter_core.dart';
import 'typedefs.dart';

/// ViewModel class for FilterList to demonstrate a more structured approach
/// to state management.
class FilterListViewModel<T> extends ChangeNotifier {
  /// Core filtering logic
  final FilterCore<T> _filterCore;

  /// Flag indicating if the view model is currently loading data
  bool _isLoading = false;

  /// Error message if any
  String? _errorMessage;

  /// Get the filter core instance
  FilterCore<T> get filterCore => _filterCore;

  /// Get the filtered items
  List<T> get filteredItems => _filteredItems;

  /// Get the selected items
  List<T> get selectedItems => _filterCore.selectedItems;

  /// Get the loading state
  bool get isLoading => _isLoading;

  /// Get the error message
  String? get errorMessage => _errorMessage;

  /// Current search query
  String _searchQuery = '';

  /// Current filtered items based on search query
  List<T> _filteredItems = [];

  /// Creates a new FilterListViewModel instance
  FilterListViewModel({
    required List<T> allItems,
    List<T>? selectedItems,
    required SearchPredict<T> searchPredicate,
    required ValidateSelectedItem<T> validateSelection,
    ValidateRemoveItem<T>? validateRemoveItem,
    OnApplyButtonClick<T>? onApplyButtonClick,
    int? maximumSelectionLength,
  }) : _filterCore = FilterCore<T>(
          allItems: allItems,
          selectedItems: selectedItems,
          searchPredicate: searchPredicate,
          validateSelection: validateSelection,
          validateRemoveItem: validateRemoveItem,
          onApplyButtonClick: onApplyButtonClick,
          maximumSelectionLength: maximumSelectionLength,
        ) {
    // Initialize filtered items with all items
    _filteredItems = _filterCore.items;
  }

  /// Update the search query and filter items
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filteredItems = _filterCore.performSearch(query);
    notifyListeners();
  }

  /// Toggle selection of an item
  void toggleSelection(T item, {bool enableOnlySingleSelection = false}) {
    _filterCore.toggleSelection(item,
        enableOnlySingleSelection: enableOnlySingleSelection);
    notifyListeners();
  }

  /// Check if an item is selected
  bool isSelected(T item) => _filterCore.isSelected(item);

  /// Clear all selected items
  void clearSelection() {
    _filterCore.clearSelectedItems();
    notifyListeners();
  }

  /// Select all available items
  void selectAll() {
    _filterCore.selectAllItems();
    notifyListeners();
  }

  /// Apply the filter
  List<T>? applyFilter() {
    final result = _filterCore.applyFilter();
    return result;
  }

  /// Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message
  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Create FilterCallbacks from this view model
  FilterCallbacks<T> createCallbacks({
    required LabelDelegate<T> labelProvider,
    OnApplyButtonClick<T>? customApplyCallback,
  }) {
    return FilterCallbacks<T>(
      searchPredicate: _filterCore.searchPredicate,
      labelProvider: labelProvider,
      validateSelection: _filterCore.validateSelection,
      validateRemoveItem: _filterCore.validateRemoveItem,
      onApplyButtonClick:
          customApplyCallback ?? _filterCore.onApplyButtonClick!,
    );
  }

  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }
}
