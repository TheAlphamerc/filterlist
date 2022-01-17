import 'package:filter_list/src/filter_list_dialog.dart';
import 'package:flutter/material.dart';

typedef SuggestionBuilder<T> = Widget Function(
    BuildContext context, T suggestion, bool isSelected);
typedef AppbarBottom = PreferredSizeWidget Function(BuildContext context);

/// The [FilterListDelegate.show] implement a search view, using [SearchDelegate]
/// {@template list_data}
/// The [listData] should be list of [T] which neeeds to filter.
/// {@endtemplate}
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
/// [onItemSearch] filter the list on the basis of search field query. It expose search api to permform search operation  outside the package.
///
/// The [onApplyButtonClick] is a callback which return list of all selected items on apply button click.  if no item is selected then it will return empty list.
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
  late List<T> templist;
  final LabelDelegate<T>? tileLabel;
  final SuggestionBuilder<T>? suggestionBuilder;
  final InputDecorationTheme? searchFieldDecorationTheme;
  final TextStyle? searchFieldStyle;
  final SearchPredict<T> onItemSearch;
  final AppbarBottom? buildAppbarBottom;
  final bool enableOnlySingleSelection;
  final OnApplyButtonClick<T> onApplyButtonClick;

  /// Search field hint text
  final String? searchFieldHint;

  /// Widget built when there's no item in [items] that
  /// matches current query.
  final Widget? emptySearchChild;
  FilterListDelegate({
    required this.listData,
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
  })  : assert(searchFieldStyle == null || searchFieldDecorationTheme == null,
            'You can\'t set both searchFieldStyle and searchFieldDecorationTheme at the same time.'),
        assert(tileLabel == null || suggestionBuilder == null,
            '''\nYou can\'t set both tileLabel and suggestionBuilder at the same time.
               \n If you want to use tileLabel, you must not set suggestionBuilder.
                \n If you want to use suggestionBuilder, you must not set tileLabel.
            '''),
        assert(tileLabel != null || suggestionBuilder != null,
            '''One of the tileLabel or suggestionBuilder is required
            '''),
        super(
            searchFieldLabel: searchFieldHint ?? "Search here..",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            searchFieldStyle: searchFieldStyle,
            searchFieldDecorationTheme: searchFieldDecorationTheme ??
                InputDecorationTheme(
                  hintStyle: TextStyle(fontSize: 14, color: Colors.black87),
                  border: InputBorder.none,
                )) {
    templist = listData;
  }

  List<T>? selectedItems;

  bool isSelected(T item) =>
      selectedItems != null && selectedItems!.contains(item);

  /// Open search view page that implement [SearchDelegate]
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
  static Future<T?>? show<T>(
      {required BuildContext context,
      required List<T> list,
      LabelDelegate<T>? tileLabel,
      required SearchPredict<T> onItemSearch,
      required OnApplyButtonClick<T> onApplyButtonClick,
      SuggestionBuilder<T>? suggestionBuilder,
      String? searchFieldHint,
      InputDecorationTheme? searchFieldDecorationTheme,
      TextStyle? searchFieldStyle,
      AppbarBottom? buildAppbarBottom,
      bool enableOnlySingleSelection = false,
      Widget? emptySearchChild}) async {
    var selectedItem = await showSearch(
      context: context,
      delegate: FilterListDelegate(
        listData: list,
        tileLabel: tileLabel,
        onItemSearch: onItemSearch,
        onApplyButtonClick: onApplyButtonClick,
        searchFieldHint: searchFieldHint,
        suggestionBuilder: suggestionBuilder,
        searchFieldDecorationTheme: searchFieldDecorationTheme,
        searchFieldStyle: searchFieldStyle,
        buildAppbarBottom: buildAppbarBottom,
        enableOnlySingleSelection: enableOnlySingleSelection,
        emptySearchChild: emptySearchChild,
      ),
    );

    return Future.value(selectedItem);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      AnimatedOpacity(
        opacity: query.isNotEmpty ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        child: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ),
      if (!enableOnlySingleSelection)
        TextButton(
            onPressed: () {
              onApplyButtonClick(selectedItems);
              close(context, null);
            },
            child: Text('Done'))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: BackButtonIcon(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    templist = listData;
    return _result(context);
  }

  Widget _result(BuildContext context) {
    return ListView.builder(
      itemCount: templist.length,
      itemBuilder: (context, index) {
        final item = templist[index];
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
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: enableOnlySingleSelection
                ? ListTile(
                    onTap: () => onItemSelect(context, item),
                    tileColor: Theme.of(context).cardColor,
                    selectedTileColor: Theme.of(context).selectedRowColor,
                    selected: isSelected(item),
                    title: _title(context, item),
                  )
                : CheckboxListTile(
                    tileColor: Theme.of(context).cardColor,
                    value: isSelected(item),
                    selected: isSelected(item),
                    onChanged: (value) => onItemSelect(context, item),
                    title: _title(context, item),
                  ),
          );
        }
      },
    );
  }

  Widget _title(BuildContext context, T item) {
    return Text(
      tileLabel!(item) ?? '',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      textAlign: TextAlign.start,
    );
  }

  void onItemSelect(BuildContext context, T item) {
    if (enableOnlySingleSelection) {
      onApplyButtonClick([item]);
      close(context, null);
    } else {
      if (selectedItems == null) {
        selectedItems = <T>[];
      }
      if (selectedItems!.contains(item)) {
        selectedItems!.remove(item);
      } else {
        selectedItems!.add(item);
      }
      final qq = query;
      query = '';
      query = qq;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    templist = listData.where((item) => onItemSearch(item, query)).toList();
    if (templist.isEmpty) {
      return emptySearchChild ?? SizedBox();
    }
    return _result(context);
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) =>
      buildAppbarBottom != null ? buildAppbarBottom!(context) : null;
}
