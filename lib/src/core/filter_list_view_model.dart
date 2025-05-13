import 'dart:async';

import 'package:flutter/material.dart';

import 'filter_callbacks.dart';
import 'filter_core.dart';
import 'filter_operations.dart';

/// ViewModel class for FilterList to demonstrate a more structured approach
/// to state management.
class FilterListViewModel<T> extends ChangeNotifier
    implements FilterOperations<T> {
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

  /// Get the loading state
  bool get isLoading => _isLoading;

  /// Get the error message
  String? get errorMessage => _errorMessage;

  /// Current search query
  String _searchQuery = '';

  /// Current filtered items based on search query
  List<T> _filteredItems = [];

  /// Timer for debouncing search queries
  Timer? _debounceTimer;

  /// The duration to wait before executing a search after input changes
  final Duration _debounceDuration;

  /// Creates a new FilterListViewModel instance
  FilterListViewModel({
    required List<T> allItems,
    List<T>? selectedItems,
    required SearchPredict<T> searchPredicate,
    required ValidateSelectedItem<T> validateSelection,
    ValidateRemoveItem<T>? validateRemoveItem,
    OnApplyButtonClick<T>? onApplyButtonClick,
    int? maximumSelectionLength,
    Duration? debounceDuration,
  })  : _filterCore = FilterCore<T>(
          allItems: allItems,
          selectedItems: selectedItems,
          searchPredicate: searchPredicate,
          validateSelection: validateSelection,
          validateRemoveItem: validateRemoveItem,
          onApplyButtonClick: onApplyButtonClick,
          maximumSelectionLength: maximumSelectionLength,
        ),
        _debounceDuration =
            debounceDuration ?? const Duration(milliseconds: 300) {
    // Initialize filtered items with all items
    _filteredItems = _filterCore.allItems;
  }

  // Implement FilterOperations interface

  @override
  List<T> get allItems => _filterCore.allItems;

  @override
  List<T> get selectedItems => _filterCore.selectedItems;

  @override
  int get selectedItemsCount => _filterCore.selectedItemsCount;

  @override
  bool get isMaximumSelectionReached => _filterCore.isMaximumSelectionReached;

  @override
  List<T> filter(String query) {
    return _filterCore.filter(query);
  }

  @override
  void toggleItem(T item, {bool enableOnlySingleSelection = false}) {
    _filterCore.toggleItem(item,
        enableOnlySingleSelection: enableOnlySingleSelection);
    notifyListeners();
  }

  @override
  bool isItemSelected(T item) => _filterCore.isItemSelected(item);

  @override
  void addItem(T item) {
    _filterCore.addItem(item);
    notifyListeners();
  }

  @override
  void removeItem(T item) {
    _filterCore.removeItem(item);
    notifyListeners();
  }

  @override
  void clearSelection() {
    _filterCore.clearSelection();
    notifyListeners();
  }

  @override
  void selectAll() {
    _filterCore.selectAll();
    notifyListeners();
  }

  @override
  List<T>? applyFilter() {
    return _filterCore.applyFilter();
  }

  /// Update the search query and filter items with debouncing
  void updateSearchQuery(String query) {
    // Cancel any previous timer
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    // Set a new timer
    _debounceTimer = Timer(_debounceDuration, () {
      _searchQuery = query;
      _filteredItems = filter(query);
      notifyListeners();
    });
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
    // Cancel any active timer to prevent memory leaks
    _debounceTimer?.cancel();

    // Clear references to release memory
    _filteredItems = [];
    _errorMessage = null;
    _isLoading = false;
    _searchQuery = '';

    super.dispose();
  }
}
