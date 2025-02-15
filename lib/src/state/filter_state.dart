import 'package:filter_list/src/state/provider.dart';
import 'package:flutter/material.dart';

class FilterState<K> extends ListenableState {
  FilterState(
      {List<K>? allItems,
      List<K>? selectedItems,
      this.maximumSelectionLength}) {
    this.selectedItems = selectedItems ?? [];
    items = allItems;
  }

  static FilterState<T> of<T>(BuildContext context) =>
      StateProvider.of<FilterState<T>>(context);
  final int? maximumSelectionLength;

  /// List of all items
  List<K>? _items;
  List<K>? get items => _items;
  set items(List<K>? value) {
    if (value == _items) {
      return;
    } else if (value == null) {
      _items = [];
    } else {
      _items = List<K>.from(value);
    }
    notifyListeners();
  }

  /// List of all selected items
  List<K>? _selectedItems;
  List<K>? get selectedItems => _selectedItems;
  set selectedItems(List<K>? value) {
    if (value == selectedItems) {
      return;
    } else if (value == null) {
      _selectedItems = [];
    } else {
      _selectedItems = List<K>.from(value);
    }

    notifyListeners();
  }

  int get selectedItemsCount => selectedItems?.length ?? 0;

  // Add item in to selected list
  void addSelectedItem(K item) {
    _selectedItems!.add(item);

    notifyListeners();
  }

  // Remove item from selected list
  void removeSelectedItem(K item) {
    _selectedItems!.remove(item);

    notifyListeners();
  }

  // perform filter operation
  void filter(bool Function(K) filter) {
    _items = _items!.where(filter).toList();
    notifyListeners();
  }

  // Clear selected list
  void clearSelectedList() {
    _selectedItems!.clear();

    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterState<K> &&
          runtimeType == other.runtimeType &&
          _items == other.items &&
          _selectedItems == other.selectedItems;

  @override
  int get hashCode => _items.hashCode ^ _selectedItems.hashCode;
}
