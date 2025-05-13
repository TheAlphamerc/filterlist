import 'package:filter_list/src/core/filter_core.dart';
import 'package:filter_list/src/core/filter_operations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FilterOperations<String> filterOperations;

  setUp(() {
    filterOperations = FilterCore<String>(
      allItems: ['apple', 'banana', 'cherry', 'date', 'elderberry'],
      selectedItems: ['banana', 'date'],
      searchPredicate: (item, query) => item.contains(query),
      validateSelection: (list, item) => list?.contains(item) ?? false,
    );
  });

  group('FilterOperations interface', () {
    test('allItems returns a copy of all items', () {
      final allItems = filterOperations.allItems;
      expect(allItems, ['apple', 'banana', 'cherry', 'date', 'elderberry']);

      // Make sure it's a copy
      allItems.add('fig');
      expect(filterOperations.allItems,
          ['apple', 'banana', 'cherry', 'date', 'elderberry']);
    });

    test('selectedItems returns a copy of selected items', () {
      final selectedItems = filterOperations.selectedItems;
      expect(selectedItems, ['banana', 'date']);

      // Make sure it's a copy
      selectedItems.add('fig');
      expect(filterOperations.selectedItems, ['banana', 'date']);
    });

    test('selectedItemsCount returns the count of selected items', () {
      expect(filterOperations.selectedItemsCount, 2);
    });

    test('filter filters items based on query', () {
      expect(filterOperations.filter('a'), ['apple', 'banana', 'date']);
      expect(filterOperations.filter('e'),
          ['apple', 'cherry', 'date', 'elderberry']);
      expect(filterOperations.filter('z'), []);
    });

    test('isItemSelected checks if an item is selected', () {
      expect(filterOperations.isItemSelected('banana'), true);
      expect(filterOperations.isItemSelected('apple'), false);
    });

    test('addItem adds an item to selection', () {
      filterOperations.addItem('cherry');
      expect(filterOperations.selectedItems, ['banana', 'date', 'cherry']);
    });

    test('removeItem removes an item from selection', () {
      filterOperations.removeItem('banana');
      expect(filterOperations.selectedItems, ['date']);
    });

    test('toggleItem toggles selection state', () {
      // Toggle an unselected item
      filterOperations.toggleItem('apple');
      expect(filterOperations.selectedItems, ['banana', 'date', 'apple']);

      // Toggle a selected item
      filterOperations.toggleItem('banana');
      expect(filterOperations.selectedItems, ['date', 'apple']);
    });

    test('clearSelection clears all selections', () {
      filterOperations.clearSelection();
      expect(filterOperations.selectedItems, []);
      expect(filterOperations.selectedItemsCount, 0);
    });

    test('selectAll selects all items', () {
      filterOperations.selectAll();
      expect(filterOperations.selectedItems,
          ['apple', 'banana', 'cherry', 'date', 'elderberry']);
      expect(filterOperations.selectedItemsCount, 5);
    });

    test('isMaximumSelectionReached respects maximum selection', () {
      final limitedFilterOperations = FilterCore<String>(
        allItems: ['apple', 'banana', 'cherry', 'date', 'elderberry'],
        selectedItems: ['banana', 'date'],
        searchPredicate: (item, query) => item.contains(query),
        validateSelection: (list, item) => list?.contains(item) ?? false,
        maximumSelectionLength: 3,
      );

      expect(limitedFilterOperations.isMaximumSelectionReached, false);

      limitedFilterOperations.addItem('cherry');
      expect(limitedFilterOperations.isMaximumSelectionReached, true);

      // Should not add more items when maximum is reached
      limitedFilterOperations.addItem('apple');
      expect(
          limitedFilterOperations.selectedItems, ['banana', 'date', 'cherry']);
    });

    test('single selection mode works correctly', () {
      filterOperations.toggleItem('apple', enableOnlySingleSelection: true);
      expect(filterOperations.selectedItems, ['apple']);

      filterOperations.toggleItem('cherry', enableOnlySingleSelection: true);
      expect(filterOperations.selectedItems, ['cherry']);
    });
  });
}
