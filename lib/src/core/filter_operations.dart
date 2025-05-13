/// Unified interface for all filter operations
///
/// This abstract class defines the standard operations that should be
/// available for any filter implementation, ensuring consistency across
/// different UI representations (dialog, widget, delegate).
abstract class FilterOperations<T> {
  /// Returns all available items for filtering
  List<T> get allItems;

  /// Returns the currently selected items
  List<T> get selectedItems;

  /// Returns the count of currently selected items
  int get selectedItemsCount;

  /// Checks if maximum selection limit has been reached
  bool get isMaximumSelectionReached;

  /// Filter items based on a search query
  List<T> filter(String query);

  /// Toggle selection state of an item
  void toggleItem(T item, {bool enableOnlySingleSelection = false});

  /// Check if an item is currently selected
  bool isItemSelected(T item);

  /// Add an item to the selection
  void addItem(T item);

  /// Remove an item from the selection
  void removeItem(T item);

  /// Select all available items
  void selectAll();

  /// Clear all selections
  void clearSelection();

  /// Apply the filter and return selected items
  List<T>? applyFilter();
}
