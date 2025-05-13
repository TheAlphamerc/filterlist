import 'dart:async';

import 'package:flutter/material.dart';

import 'filter_callbacks.dart';
import 'filter_core.dart';
import 'filter_operations.dart';
import 'filter_ui_config.dart';

/// A Provider-based state management solution for the FilterList package.
/// This provider is designed to be used with the Flutter Provider package
/// or directly as an InheritedWidget.
class FilterListProvider<T> extends InheritedNotifier<FilterListController<T>> {
  /// Creates a FilterListProvider.
  const FilterListProvider({
    Key? key,
    required FilterListController<T> controller,
    required Widget child,
  }) : super(key: key, notifier: controller, child: child);

  /// Gets the controller from the provider.
  static FilterListController<R> of<R>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<FilterListProvider<R>>();
    if (provider == null) {
      throw FlutterError(
        'FilterListProvider.of() called with a context that does not contain a FilterListProvider<$R>.\n'
        'No FilterListProvider<$R> ancestor could be found starting from the context that was passed to '
        'FilterListProvider.of<$R>().',
      );
    }
    return provider.notifier!;
  }
}

/// Controller class that manages the state for FilterList operations.
/// This class is designed to be used with FilterListProvider.
class FilterListController<T> extends ChangeNotifier
    implements FilterOperations<T> {
  /// The underlying filter operations instance that handles filtering logic.
  final FilterCore<T> _filterCore;

  /// The UI configuration for the filter list.
  FilterUIConfig _uiConfig;

  /// The current search query.
  String _searchQuery = '';

  /// The filtered items based on the current search query.
  List<T> _filteredItems = [];

  /// Flag indicating if the controller is busy performing an operation.
  bool _isBusy = false;

  /// Error message if any operation fails.
  String? _errorMessage;

  /// Debounce timer for search operations to avoid excessive filtering.
  Timer? _debounceTimer;

  /// Duration for debouncing search operations.
  final Duration _debounceDuration;

  /// Creates a new FilterListController instance.
  FilterListController({
    required List<T> allItems,
    List<T>? selectedItems,
    required SearchPredict<T> searchPredicate,
    required ValidateSelectedItem<T> validateSelection,
    ValidateRemoveItem<T>? validateRemoveItem,
    OnApplyButtonClick<T>? onApplyButtonClick,
    int? maximumSelectionLength,
    FilterUIConfig? uiConfig,
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
        _uiConfig = uiConfig ?? const FilterUIConfig(),
        _debounceDuration =
            debounceDuration ?? const Duration(milliseconds: 300) {
    // Initialize filtered items with all items
    _filteredItems = _filterCore.allItems;
  }

  /// Gets the filter operations instance.
  FilterCore<T> get filterCore => _filterCore;

  /// Gets the UI configuration.
  FilterUIConfig get uiConfig => _uiConfig;

  /// Gets the current search query.
  String get searchQuery => _searchQuery;

  /// Gets the filtered items based on the current search query.
  List<T> get filteredItems => _filteredItems;

  /// Indicates if the controller is busy performing an operation.
  bool get isBusy => _isBusy;

  /// Gets the error message if any.
  String? get errorMessage => _errorMessage;

  // Implement FilterOperations interface

  @override
  List<T> get allItems => _filterCore.allItems;

  @override
  List<T> get selectedItems => _filterCore.selectedItems;

  @override
  int get selectedItemsCount => _filterCore.selectedItemsCount;

  @override
  bool get isMaximumSelectionReached => _filterCore.isMaximumSelectionReached;

  /// Updates the search query and filters items accordingly with debouncing.
  void updateSearchQuery(String query) {
    _searchQuery = query;

    // Cancel previous timer if exists
    _debounceTimer?.cancel();

    // Set a new timer
    _debounceTimer = Timer(_debounceDuration, () {
      _filteredItems = filter(query);
      notifyListeners();
    });
  }

  /// Updates the search query and filters items immediately without debouncing.
  void updateSearchQueryImmediately(String query) {
    _searchQuery = query;
    _filteredItems = filter(query);
    notifyListeners();
  }

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

  /// Sets the busy state of the controller.
  void setBusy(bool busy) {
    _isBusy = busy;
    notifyListeners();
  }

  /// Sets an error message.
  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Creates FilterCallbacks from this controller.
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

  /// Updates the UI configuration.
  void updateUIConfig(FilterUIConfig config) {
    _uiConfig = config;
    notifyListeners();
  }

  @override
  void dispose() {
    // Cancel any active debounce timer to prevent memory leaks
    _debounceTimer?.cancel();

    // Clear references to release memory
    _filteredItems = [];
    _errorMessage = null;
    _isBusy = false;
    _searchQuery = '';

    super.dispose();
  }
}
