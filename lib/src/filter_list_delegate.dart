import 'dart:async';

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

typedef SuggestionBuilder<T> = Widget Function(
    BuildContext context, T suggestion, bool isSelected);
typedef AppbarBottom = PreferredSizeWidget Function(BuildContext context);

/// The [FilterListDelegate.show] implement a search view, using [SearchDelegate]
/// The [listData] should be list of [T] which needs to filter.
///
/// the `selectedListData` should be sub list of [listData].
///
/// The [tileLabel] is a callback which required [String] value in return. It used this value to display text on choice chip.
///
/// The [suggestionBuilder] is a builder that builds a widget for each item available in the search list. If no builder is provided by the user, the package will try
/// to display a [ListTile] for each child, with a string  representation of itself as the title
///
/// The [searchFieldDecorationTheme] is used to configure the search field's visuals.
///
/// Only one of [searchFieldStyle] or [searchFieldDecorationTheme] can be non-null.
///
/// [onItemSearch] filter the list on the basis of search field query. It expose search api to perform search operation  outside the package.
///
/// The [onApplyButtonClick] is a callback which return list of all selected items on apply button click.  if no item is selected then it will return empty list.
///
/// The [applyButtonStyle] is used to configure the apply button's visuals.
///
/// The [applyButtonText] is used to configure the apply button's text.
///
/// The [buildAppbarBottom] is used to configure the bottom of the appbar.
///
/// The [enableOnlySingleSelection] is used to configure the selection mode. If true, only one item can be selected at a time.
///
/// The [hideClearSearchIcon] is used to configure the clear search icon. If true, the clear search icon will be hidden.
///
/// The [emptySearchChild] is used to configure the empty search child. If null, the empty search child will be a SizedBox.
///
/// The [searchFieldHint] is used to configure the search field hint text.
///
/// The [theme] is used to configure the theme of the filter list delegate.
///
/// The [maximumSelectionLength] is used to configure the maximum number of items that can be selected.
///
/// The [selectedListData] is used to configure the list of items that are selected by default.
///
/// The [searchFieldStyle] is used to configure the search field's text style.
///
/// ### This example shows how to use [FilterListDialog]
///
///  ``` dart
/// await FilterListDelegate.show<String>(
///      context: context,
///      list: ['Jon', 'Abraham', 'John', 'Peter', 'Paul', 'Mary', 'Jane'],
///      onItemSearch: (user, query) {
///        return user.toLowerCase().contains(query.toLowerCase());
///      },
///      tileLabel: (user) => user,
///      emptySearchChild: Center(child: Text('No user found')),
///      enableOnlySingleSelection: true,
///      searchFieldHint: 'Search Here..',
///      onApplyButtonClick: (list) {
///         // do something with list
///      },
///    );
/// ```
/// {@macro control_buttons}
class FilterListDelegate<T> extends SearchDelegate<T?> {
  final List<T> listData;
  late List<T> tempList;
  final LabelDelegate<T>? tileLabel;
  final SuggestionBuilder<T>? suggestionBuilder;

  @override
  // ignore: overridden_fields
  final InputDecorationTheme? searchFieldDecorationTheme;

  @override
  // ignore: overridden_fields
  final TextStyle? searchFieldStyle;
  final SearchPredict<T> onItemSearch;
  final AppbarBottom? buildAppbarBottom;
  final bool enableOnlySingleSelection;
  final bool hideClearSearchIcon;
  final OnApplyButtonClick<T> onApplyButtonClick;
  final String applyButtonText;

  /// Search field hint text
  final String? searchFieldHint;

  /// Widget built when there's no item in [items] that
  /// matches current query.
  final Widget? emptySearchChild;

  final ButtonStyle? applyButtonStyle;
  final List<T>? selectedListData;
  final int? maximumSelectionLength;

  final FilterListDelegateThemeData? theme;

  /// The core filtering operations handler
  late final FilterOperations<T> _filterOperations;

  /// Timer for debouncing search queries
  Timer? _debounceTimer;

  /// Duration for debouncing search operations
  final Duration _debounceDuration;

  FilterListDelegate({
    required this.listData,
    this.selectedListData,
    required this.onItemSearch,
    required this.onApplyButtonClick,
    this.tileLabel,
    this.enableOnlySingleSelection = false,
    this.searchFieldHint,
    this.suggestionBuilder,
    this.searchFieldDecorationTheme,
    this.searchFieldStyle,
    this.buildAppbarBottom,
    this.emptySearchChild,
    this.theme,
    this.applyButtonStyle,
    this.maximumSelectionLength,
    this.hideClearSearchIcon = false,
    this.applyButtonText = 'Apply',
    Duration? debounceDuration,
  })  : _debounceDuration =
            debounceDuration ?? const Duration(milliseconds: 300),
        assert(searchFieldStyle == null || searchFieldDecorationTheme == null,
            "You can't set both searchFieldStyle and searchFieldDecorationTheme at the same time."),
        assert(tileLabel == null || suggestionBuilder == null, '''
\nYou can't set both tileLabel and suggestionBuilder at the same time.
               \n If you want to use tileLabel, you must not set suggestionBuilder.
                \n If you want to use suggestionBuilder, you must not set tileLabel.
            '''),
        assert(tileLabel != null || suggestionBuilder != null, '''
One of the tileLabel or suggestionBuilder is required
            '''),
        super(
            searchFieldLabel: searchFieldHint ?? "Search here..",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            searchFieldStyle: searchFieldStyle,
            searchFieldDecorationTheme: searchFieldDecorationTheme) {
    tempList = List<T>.from(listData);

    // Initialize filter operations
    _filterOperations = FilterCore<T>(
      allItems: listData,
      selectedItems: selectedListData,
      searchPredicate: onItemSearch,
      validateSelection: (list, item) => list?.contains(item) ?? false,
      onApplyButtonClick: onApplyButtonClick,
      maximumSelectionLength:
          enableOnlySingleSelection ? 1 : maximumSelectionLength,
    );
  }

  /// Update the search query with debouncing
  void updateSearchQuery(String query, BuildContext context) {
    // Cancel previous timer if exists
    _debounceTimer?.cancel();

    // Set a new timer
    _debounceTimer = Timer(_debounceDuration, () {
      tempList = query.isEmpty
          ? List<T>.from(listData)
          : _filterOperations.filter(query);

      // Trigger UI update
      showResults(context);
    });
  }

  @override
  void dispose() {
    // Cancel debounce timer to prevent memory leaks
    _debounceTimer?.cancel();
    super.dispose();
  }

  /// Get the currently selected items
  List<T> get selectedItems => _filterOperations.selectedItems;

  /// Check if an item is selected
  bool isSelected(T item) => _filterOperations.isItemSelected(item);

  /// Toggle selection of an item
  void toggleSelection(T item) {
    _filterOperations.toggleItem(item,
        enableOnlySingleSelection: enableOnlySingleSelection);
  }

  @override
  Widget buildResults(BuildContext context) {
    // Results are already computed in updateSearchQuery
    // Just return the widget with current tempList
    return buildBottomSheet(context, tempList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Initial search or when text changes
    updateSearchQuery(query, context);

    // If no results, show empty state
    if (tempList.isEmpty) {
      return emptySearchChild ?? const SizedBox();
    }

    // Show results
    return buildBottomSheet(context, tempList);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (!hideClearSearchIcon && query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
      else
        Container(),
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: TextButton(
          style: applyButtonStyle,
          onPressed: () {
            // Use filter operations to apply filter
            _filterOperations.applyFilter();
            close(context, null);
          },
          child: Text(
            applyButtonText,
            style: theme?.applyButtonTextStyle ??
                const TextStyle(color: Colors.blue),
          ),
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const BackButtonIcon(),
    );
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    if (buildAppbarBottom != null) {
      return buildAppbarBottom!(context);
    }
    return null;
  }

  Widget buildBottomSheet(BuildContext context, List<T> items) {
    return StateProvider<FilterState<T>>(
      value: FilterState<T>(
          allItems: listData,
          selectedItems: selectedItems,
          maximumSelectionLength: maximumSelectionLength),
      child: FilterListDelegateTheme(
        theme: theme ?? FilterListDelegateThemeData(),
        child: Builder(
          builder: (BuildContext innerContext) {
            // Remove reference to unused variable 'state'
            StateProvider.of<FilterState<T>>(
              innerContext,
              rebuildOnChange: true,
            );

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final theme = FilterListDelegateTheme.of(innerContext);
                final item = items[index];
                final selected = isSelected(item);

                // Check if maximum selection is reached
                final maxSelectionReached =
                    !selected && _filterOperations.isMaximumSelectionReached;

                if (suggestionBuilder != null) {
                  return GestureDetector(
                    onTap: () => onItemSelect(context, item),
                    child: suggestionBuilder!(
                      context,
                      item,
                      isSelected(item),
                    ),
                  );
                } else {
                  return Container(
                    margin: theme.tileMargin,
                    decoration: BoxDecoration(
                      boxShadow: theme.tileShadow,
                      border: theme.tileBorder,
                    ),
                    child: enableOnlySingleSelection
                        ? ListTileTheme(
                            data: theme.listTileTheme,
                            child: ListTile(
                              onTap: () => onItemSelect(context, item),
                              selected: selected,
                              title: _title(context, item, theme.tileTextStyle),
                            ),
                          )
                        : ListTileTheme(
                            data: theme.listTileTheme,
                            child: CheckboxListTile(
                              value: selected,
                              selected: selected,
                              onChanged: maxSelectionReached
                                  ? null
                                  : (value) => onItemSelect(context, item),
                              title: _title(context, item, theme.tileTextStyle),
                            ),
                          ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _title(BuildContext context, T item, TextStyle? style) {
    return Text(
      tileLabel!(item) ?? '',
      style: style,
      textAlign: TextAlign.start,
    );
  }

  void onItemSelect(BuildContext context, T item) {
    if (enableOnlySingleSelection) {
      onApplyButtonClick([item]);
      close(context, null);
    } else {
      // Use filter operations to toggle item selection
      toggleSelection(item);

      // Update filter state for compatibility with old implementation
      final state = StateProvider.of<FilterState<T>>(context);
      state.selectedItems = selectedItems;

      // Refresh the view
      final currentQuery = query;
      query = '';
      query = currentQuery;
    }
  }
}

/// Modern version of FilterListDelegate that uses FilterOperations interface
/// for better state management and integration with the core architecture.
///
/// This implementation provides a more maintainable and extensible approach to filtering
/// by leveraging the FilterOperations interface for all filtering logic, making the UI layer
/// focused solely on presentation concerns.
class FilterListDelegateModern<T> extends SearchDelegate<List<T>?> {
  /// All items available for filtering
  final List<T> allItems;

  /// Items currently matching the search query
  late List<T> filteredItems;

  /// The filter operations core that handles all filtering logic
  final FilterOperations<T> filterOperations;

  /// Function to get the display label for each item
  final LabelDelegate<T> labelProvider;

  /// Custom builder for suggestion items
  final SuggestionBuilder<T>? suggestionBuilder;

  /// Builder for the bottom part of the app bar
  final AppbarBottom? buildAppbarBottom;

  /// Whether to enable only single selection
  final bool enableOnlySingleSelection;

  /// Whether to hide the clear search icon
  final bool hideClearSearchIcon;

  /// The UI configuration
  final FilterUIConfig uiConfig;

  /// Widget to show when search returns no results
  final Widget? emptySearchChild;

  /// Theme data for the delegate
  final FilterListDelegateThemeData? theme;

  /// Style for the apply button
  final ButtonStyle? applyButtonStyle;

  /// Creates a FilterListDelegateModern instance
  ///
  /// [allItems]: List of all items available for filtering
  /// [filterOperations]: Implementation of FilterOperations that handles filtering logic
  /// [labelProvider]: Function to extract display text from items
  /// [uiConfig]: Configuration for UI elements like search hint text, button labels, etc.
  /// [suggestionBuilder]: Optional custom builder for suggestion items
  /// [buildAppbarBottom]: Optional builder for appbar bottom widget
  /// [emptySearchChild]: Optional widget to display when no results are found
  /// [theme]: Optional theme data for visual styling
  /// [applyButtonStyle]: Optional style for the apply button
  /// [hideClearSearchIcon]: Whether to hide the clear icon in search field
  /// [enableOnlySingleSelection]: Whether to enable single selection mode
  FilterListDelegateModern({
    required this.allItems,
    required this.filterOperations,
    required this.labelProvider,
    this.uiConfig = const FilterUIConfig(),
    this.suggestionBuilder,
    this.buildAppbarBottom,
    this.emptySearchChild,
    this.theme,
    this.applyButtonStyle,
    this.hideClearSearchIcon = false,
    this.enableOnlySingleSelection = false,
  }) : super(
          searchFieldLabel: uiConfig.searchFieldHint ?? "Search here..",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        ) {
    filteredItems = List<T>.from(allItems);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (!hideClearSearchIcon && query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
      else
        Container(),
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: TextButton(
          style: applyButtonStyle,
          onPressed: () {
            // Apply the filter and close the delegate
            final result = filterOperations.applyFilter();
            close(context, result);
          },
          child: Text(
            uiConfig.applyButtonText,
            style: theme?.applyButtonTextStyle ??
                const TextStyle(color: Colors.blue),
          ),
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const BackButtonIcon(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter the items based on the query
    filteredItems = query.isEmpty ? allItems : filterOperations.filter(query);
    return _buildItemList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Filter the items based on the query
    filteredItems = query.isEmpty ? allItems : filterOperations.filter(query);

    if (filteredItems.isEmpty) {
      return emptySearchChild ?? const SizedBox();
    }

    return _buildItemList(context);
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    return buildAppbarBottom?.call(context);
  }

  /// Builds the list of filtered items
  Widget _buildItemList(BuildContext context) {
    final effectiveTheme = theme ?? FilterListDelegateThemeData();

    return FilterListDelegateTheme(
      theme: effectiveTheme,
      child: Builder(
        builder: (BuildContext innerContext) {
          return ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              final selected = filterOperations.isItemSelected(item);
              final maxSelectionReached =
                  !selected && filterOperations.isMaximumSelectionReached;

              if (suggestionBuilder != null) {
                return GestureDetector(
                  onTap: () => _toggleSelection(context, item),
                  child: suggestionBuilder!(
                    context,
                    item,
                    selected,
                  ),
                );
              } else {
                return Container(
                  margin: effectiveTheme.tileMargin,
                  decoration: BoxDecoration(
                    boxShadow: effectiveTheme.tileShadow,
                    border: effectiveTheme.tileBorder,
                  ),
                  child: enableOnlySingleSelection
                      ? ListTileTheme(
                          data: effectiveTheme.listTileTheme,
                          child: ListTile(
                            onTap: () => _toggleSelection(context, item),
                            selected: selected,
                            title: _buildTitle(
                                context, item, effectiveTheme.tileTextStyle),
                          ),
                        )
                      : ListTileTheme(
                          data: effectiveTheme.listTileTheme,
                          child: CheckboxListTile(
                            value: selected,
                            selected: selected,
                            onChanged: maxSelectionReached
                                ? null
                                : (_) => _toggleSelection(context, item),
                            title: _buildTitle(
                                context, item, effectiveTheme.tileTextStyle),
                          ),
                        ),
                );
              }
            },
          );
        },
      ),
    );
  }

  /// Builds the title widget for an item
  Widget _buildTitle(BuildContext context, T item, TextStyle? style) {
    return Text(
      labelProvider(item) ?? '',
      style: style,
      textAlign: TextAlign.start,
    );
  }

  /// Toggles the selection state of an item
  void _toggleSelection(BuildContext context, T item) {
    filterOperations.toggleItem(item,
        enableOnlySingleSelection: enableOnlySingleSelection);

    if (enableOnlySingleSelection) {
      // If single selection is enabled, apply filter and close on selection
      final result = filterOperations.applyFilter();
      close(context, result);
    } else {
      // Refresh the view to show updated selection state
      final currentQuery = query;
      query = '';
      query = currentQuery;
    }
  }
}

extension FilterListDelegateExtension on FilterListDelegate {
  /// Show a FilterListDelegate with modern implementation using FilterOperations interface
  static Future<List<T>?> showFilterListDelegateModern<T>({
    required BuildContext context,
    required List<T> listData,
    List<T>? selectedListData,
    required LabelDelegate<T> labelProvider,
    required SearchPredict<T> searchPredicate,
    required OnApplyButtonClick<T> onApplyButtonClick,
    ValidateRemoveItem<T>? validateRemoveItem,
    ValidateSelectedItem<T>? validateSelection,
    SuggestionBuilder<T>? suggestionBuilder,
    String? searchFieldHint,
    AppbarBottom? buildAppbarBottom,
    bool enableOnlySingleSelection = false,
    int? maximumSelectionLength,
    bool hideClearSearchIcon = false,
    Widget? emptySearchChild,
    FilterListDelegateThemeData? theme,
    ButtonStyle? applyButtonStyle,
    FilterUIConfig? uiConfig,
    Duration? debounceDuration,
  }) {
    // Create a filter core using the FilterListBase utility
    final filterCore = FilterListBase.createFilterCore<T>(
      allItems: listData,
      selectedItems: selectedListData,
      searchPredicate: searchPredicate,
      validateSelection:
          validateSelection ?? ((list, item) => list?.contains(item) ?? false),
      validateRemoveItem: validateRemoveItem,
      onApplyButtonClick: onApplyButtonClick,
      maximumSelectionLength:
          enableOnlySingleSelection ? 1 : maximumSelectionLength,
    );

    // Use default UI config if not provided
    final effectiveUIConfig = uiConfig ??
        FilterUIConfig(
          searchFieldHint: searchFieldHint,
          enableOnlySingleSelection: enableOnlySingleSelection,
          applyButtonText: 'Apply',
        );

    // Show search with modern delegate
    return showSearch<List<T>?>(
      context: context,
      delegate: FilterListDelegateModern<T>(
        allItems: listData,
        filterOperations: filterCore,
        labelProvider: labelProvider,
        uiConfig: effectiveUIConfig,
        suggestionBuilder: suggestionBuilder,
        buildAppbarBottom: buildAppbarBottom,
        emptySearchChild: emptySearchChild,
        theme: theme,
        applyButtonStyle: applyButtonStyle,
        hideClearSearchIcon: hideClearSearchIcon,
        enableOnlySingleSelection: enableOnlySingleSelection,
      ),
    );
  }

  /// Show a FilterListDelegate with the core implementation
  ///
  /// This method uses the FilterCallbacks class to encapsulate all callback functions,
  /// making the API cleaner and more maintainable.
  static Future<List<T>?> showWithCore<T>({
    required BuildContext context,
    required List<T> allItems,
    List<T>? selectedItems,
    required FilterCallbacks<T> callbacks,
    SuggestionBuilder<T>? suggestionBuilder,
    AppbarBottom? buildAppbarBottom,
    bool enableOnlySingleSelection = false,
    int? maximumSelectionLength,
    bool hideClearSearchIcon = false,
    Widget? emptySearchChild,
    FilterListDelegateThemeData? theme,
    ButtonStyle? applyButtonStyle,
    FilterUIConfig? uiConfig,
    Duration? debounceDuration,
  }) {
    return showFilterListDelegateModern<T>(
      context: context,
      listData: allItems,
      selectedListData: selectedItems,
      labelProvider: callbacks.labelProvider,
      searchPredicate: callbacks.searchPredicate,
      validateSelection: callbacks.validateSelection,
      validateRemoveItem: callbacks.validateRemoveItem,
      onApplyButtonClick: callbacks.onApplyButtonClick,
      suggestionBuilder: suggestionBuilder,
      buildAppbarBottom: buildAppbarBottom,
      enableOnlySingleSelection: enableOnlySingleSelection,
      maximumSelectionLength: maximumSelectionLength,
      hideClearSearchIcon: hideClearSearchIcon,
      emptySearchChild: emptySearchChild,
      theme: theme,
      applyButtonStyle: applyButtonStyle,
      uiConfig: uiConfig,
      debounceDuration: debounceDuration,
    );
  }
}
