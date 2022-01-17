import 'package:filter_list/src/state/provider.dart';
import 'package:flutter/material.dart';

class FilterState<K> extends ListenableState {
  FilterState({List<K>? allItems, List<K>? selctedItems}) {
    this.selctedItems = selctedItems;
    this.items = allItems;
  }

  static FilterState<T> of<T>(BuildContext context) =>
      StateProvider.of<FilterState<T>>(context);

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

  /// List of all selcted items
  List<K>? _selctedItems;
  List<K>? get selctedItems => _selctedItems;
  set selctedItems(List<K>? value) {
    if (value == selctedItems) {
      return;
    } else if (value == null) {
      _selctedItems = [];
    } else {
      _selctedItems = List<K>.from(value);
    }

    notifyListeners();
  }

  int get selctedItemsCount => selctedItems?.length ?? 0;

  // Add item in to selected list
  void addSelectedItem(K item) {
    _selctedItems!.add(item);

    notifyListeners();
  }

  // Remove item from selected list
  void removeSelectedItem(K item) {
    _selctedItems!.remove(item);

    notifyListeners();
  }

  // perform filter operation
  void filter(bool Function(K) filter) {
    _items = _items!.where(filter).toList();
    notifyListeners();
  }

  // Clear selected list
  void clearSelectedList() {
    _selctedItems!.clear();

    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterState<K> &&
          runtimeType == other.runtimeType &&
          _items == other.items &&
          _selctedItems == other.selctedItems;

  @override
  int get hashCode => _items.hashCode ^ _selctedItems.hashCode;
}
