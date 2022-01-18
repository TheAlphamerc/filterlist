part of 'filter_list_dialog.dart';

typedef ValidateSelectedItem<T> = bool Function(List<T>? list, T item);
typedef OnApplyButtonClick<T> = void Function(List<T>? list);
typedef ChoiceChipBuilder<T> = Widget Function(
    BuildContext context, T? item, bool? iselected);
// typedef ItemSearchDelegate<T> = List<T> Function(List<T>? list, String query);
typedef SearchPredict<T> = bool Function(T item, String query);
typedef LabelDelegate<T> = String? Function(T?);
typedef ValidateRemoveItem<T> = List<T> Function(List<T>? list, T item);

enum ContolButtonType { All, Reset }

/// The [FilterListWidget] is a widget with some filter utilities and callbacks which helps in single/multiple selection from list of data.
///
/// {@template arguments}
///
/// ### This example shows how to use [FilterListWidget]
///  ``` dart
///  FilterListWidget<String>(
///    listData: ["One","Two","Three", "Four","five", "Six","Seven","Eight","Nine","Ten"],
///    selectedListData: ["One", "Three", "Four", "Eight", "Nine"],
///    hideHeaderText: true,
///    height: MediaQuery.of(context).size.height,
///    // hideHeaderText: true,
///    onApplyButtonClick: (list) {
///      Navigator.pop(context, list);
///    },
///    choiceChipLabel: (item) {
///      /// Used to print text on chip
///      return item;
///    },
///    validateSelectedItem: (list, val) {
///      ///  identify if item is selected or not
///      return list!.contains(val);
///    },
///    onItemSearch: (list, text) {
///      /// When text change in search text field then return list containing that text value
///      ///
///      ///Check if list has value which matchs to text
///      if (list!.any((element) =>
///          element.toLowerCase().contains(text.toLowerCase()))) {
///        /// return list which contains matches
///        return list
///            .where((element) =>
///                element.toLowerCase().contains(text.toLowerCase()))
///            .toList();
///      }
///      return [];
///    },
///   )
/// ```
/// {@endtemplate}
class FilterListWidget<T extends Object> extends StatelessWidget {
  const FilterListWidget({
    Key? key,
    this.themeData,
    this.listData,
    required this.validateSelectedItem,
    this.validateRemoveItem,
    required this.choiceChipLabel,
    required this.onItemSearch,
    this.selectedListData,
    this.onApplyButtonClick,
    this.choiceChipBuilder,
    this.headerCloseIcon,
    this.headlineText,
    this.hideSelectedTextCount = false,
    this.hideSearchField = false,
    this.hideCloseIcon = true,
    this.hideHeader = false,
    this.backgroundColor = Colors.white,
    this.enableOnlySingleSelection = false,
    this.allButtonText = 'All',
    this.applyButtonText = 'Apply',
    this.resetButtonText = 'Reset',
    this.selectedItemsText = 'selected items',
    this.controlButtons = const [ContolButtonType.All, ContolButtonType.Reset],
  }) : super(key: key);

  /// Filter theme
  final FilterListThemeData? themeData;

  /// Pass list containing all data which neeeds to filter
  final List<T>? listData;

  /// The [selectedListData] is used to preselect the choice chips.
  /// It takes list of object and this list should be subset og [listData]
  final List<T>? selectedListData;
  final Color? backgroundColor;

  final String? headlineText;

  final bool hideSelectedTextCount;
  final bool hideSearchField;

  /// if true then it hides close icon.
  final bool hideCloseIcon;

  /// Widget to close the dialog.
  ///
  /// If widget is not provided then default close icon will be used.
  final Widget? headerCloseIcon;

  /// If true then it hide complete header section.
  final bool? hideHeader;

  /// if [enableOnlySingleSelection] is true then it disabled the multiple selection.
  /// and enabled the single selection model.
  ///
  /// Defautl value is `false`
  final bool enableOnlySingleSelection;

  /// The `onApplyButtonClick` is a callback which return list of all selected items on apply button click.  if no item is selected then it will return empty list.
  final OnApplyButtonClick<T>? onApplyButtonClick;

  /// The `validateSelectedItem` dentifies weather a item is selecte or not.
  final ValidateSelectedItem<T> validateSelectedItem; /*required*/

  /// The `validateRemoveItem` identifies if a item should be remove or not and returns the list filtered.
  final ValidateRemoveItem<T>? validateRemoveItem;

  /// The `onItemSearch` is delagate which filter the list on the basis of search field text.
  final SearchPredict<T> onItemSearch; /*required*/

  /// The `choiceChipLabel` is callback which required [String] value to display text on choice chip.
  final LabelDelegate<T> choiceChipLabel; /*required*/

  /// The `choiceChipBuilder` is a builder to design custom choice chip.
  final ChoiceChipBuilder? choiceChipBuilder;

  /// Apply Button Label
  final String? applyButtonText;

  /// Reset Button Label
  final String? resetButtonText;

  /// All Button Label
  final String? allButtonText;

  /// Selected items count text
  final String? selectedItemsText;

  /// {@template control_buttons}
  /// control buttons to show on bottom of dialog along with 'Apply' button.
  ///
  /// If `ContolButtonType.All` is passed then it will show 'All' and 'Apply' button.
  ///
  /// If `ContolButtonType.Reset` is passed then it will show 'Reset' and 'Apply' button.
  ///
  /// Default value is `[ContolButton.All, ContolButton.Reset]`
  ///
  /// If `enableOnlySingleSelection` is true then it will hide 'All' button.
  /// {@endtemplate}
  final List<ContolButtonType> controlButtons;

  Widget _body(BuildContext context) {
    final theme = FilterListTheme.of(context);
    return Container(
      color: theme.backgroundColor,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              hideHeader!
                  ? SizedBox()
                  : Header(
                      headlineText: headlineText,
                      hideSearchField: hideSearchField,
                      hideCloseIcon: hideCloseIcon,
                      headerCloseIcon: headerCloseIcon,
                      onSearch: (String value) {
                        if (value.isEmpty) {
                          FilterState.of<T>(context).items = listData;
                          return;
                        }
                        FilterState.of<T>(context)
                            .filter((item) => onItemSearch(item, value));
                      },
                    ),
              hideSelectedTextCount
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: ChangeNotifierProvider<FilterState<T>>(
                        builder: (context, state, child) => Text(
                          '${state.selctedItemsCount} $selectedItemsText',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
              Expanded(
                child: ChoiceList<T>(
                  choiceChipBuilder: choiceChipBuilder,
                  choiceChipLabel: choiceChipLabel,
                  enableOnlySingleSelection: enableOnlySingleSelection,
                  validateSelectedItem: validateSelectedItem,
                  validateRemoveItem: validateRemoveItem,
                ),
              ),
            ],
          ),

          // /// Bottom section for control buttons
          ControlButtonBar<T>(
            controlButtons: controlButtons,
            allButtonText: allButtonText,
            applyButtonText: applyButtonText,
            resetButtonText: resetButtonText,
            enableOnlySingleSelection: enableOnlySingleSelection,
            onApplyButtonClick: () {
              final selctedItems = FilterState.of<T>(context).selctedItems;
              if (onApplyButtonClick != null) {
                onApplyButtonClick!.call(selctedItems);
              } else {
                Navigator.pop(context, selctedItems);
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StateProvider<FilterState<T>>(
      value: FilterState<T>(
        allItems: listData,
        selctedItems: selectedListData,
      ),
      child: FilterListTheme(
        theme: themeData ?? FilterListThemeData.light(context),
        child: Builder(
          builder: (BuildContext innerContext) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: _body(innerContext),
            );
          },
        ),
      ),
    );
  }
}
