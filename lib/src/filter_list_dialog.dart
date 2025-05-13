library filter_list;

import 'package:filter_list/src/core/core.dart';
import 'package:filter_list/src/core/typedefs.dart' as core_types;
import 'package:filter_list/src/state/filter_state.dart';
import 'package:filter_list/src/state/provider.dart';
import 'package:filter_list/src/theme/theme.dart';
import 'package:filter_list/src/widget/choice_list.dart';
import 'package:filter_list/src/widget/control_button_bar.dart';
import 'package:filter_list/src/widget/filter_list_widget_modern.dart';
import 'package:filter_list/src/widget/header.dart';
import 'package:flutter/material.dart';

part 'filter_list_widget.dart';

/// The [FilterListDialog.display] is a [Dialog] with some filter utilities and callbacks which helps in single/multiple selection from list of data.
///
/// {@template arguments}
/// The [listData] should be list of dynamic data which needs to filter.
///
/// The [selectedListData] should be sub list of [listData]. The list passed to [selectedListData] should available in [listData].
///
/// The [choiceChipLabel] is a callback which required [String] value in return. It used this value to display text on choice chip.
///
/// The [validateSelectedItem] used to identifies weather a item is selected or not.
///
/// [onItemSearch] filter the list on the basis of search field text. It expose search api to perform search operation according to requirement.
/// When text change in search text field then return a list of element which contains specific text. if no element found then it should return empty list.
///
///
/// The [choiceChipBuilder] is a builder to design custom choice chip.
///
///
/// The [onApplyButtonClick] is a callback which return list of all selected items on apply button click.  if no item is selected then it will return empty list.
/// The [useSafeArea] argument is used to indicate if the dialog should only display in 'safe' areas of the screen not used by the operating system (see [SafeArea] for more details). It is true by default, which means the dialog will not overlap operating system areas. If it is set to false the dialog will only be constrained by the screen size. It can not be null.
///
/// The [useRootNavigator] argument is used to determine whether to push the dialog to the [Navigator] furthest from or nearest to the given context. By default, useRootNavigator is true and the dialog route created by this method is pushed to the root navigator. It can not be null.
///
/// The [routeSettings] argument is passed to [showGeneralDialog], see [RouteSettings] for details.
///
/// The [insetPadding] is the amount of padding added to [MediaQueryData.viewInsets] on the outside of the dialog.
/// This defines the minimum space between the screen's edges and the dialog.
///
/// Defaults to EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0).
///
/// The [controlButtons] is a list of [ControlButtonType] which is used to display control buttons on dialog.
///
/// The [enableOnlySingleSelection] is a boolean which is used to enable/disable single selection mode.
///
/// The [maximumSelectionLength] is a integer which is used to limit the maximum selection length.
/// {@endtemplate}
///
/// ### This example shows how to use [FilterListDialog]
///
///  ``` dart
/// void _openFilterDialog() async {
///    await FilterListDialog.display<String>(context,
///        listData: ["One", "Two", "Three", "Four","five","Six","Seven","Eight","Nine","Ten"],
///        selectedListData: ["One", "Three", "Four","Eight","Nine"],
///        choiceChipLabel: (item) {
///          return item;
///        },
///        validateSelectedItem: (list, val) {
///          return list!.contains(val);
///        },
///        onItemSearch: (data, query) {
///          return data!.toLowerCase().contains(query.toLowerCase());
///        },
///        height: 480,
///        borderRadius: 20,
///        headlineText: "Select Count",
///        searchFieldHintText: "Search Here",
///        onApplyButtonClick: (list) {
///          if (list != null) {
///            setState(() {
///             var selectedList = List.from(list);
///            });
///            Navigator.pop(context);
///          }
///        });
///  }
/// ```
/// {@macro control_buttons}

class FilterListDialog {
  static Future display<T extends Object>(
    BuildContext context, {
    /// Filter theme
    FilterListThemeData? themeData,

    /// Pass list containing all data which needs to filter.
    required List<T> listData,

    /// pass selected list of object
    /// every object on selectedListData should be present in list data.
    List<T>? selectedListData,

    /// Display text on choice chip.
    required LabelDelegate<T> choiceChipLabel,

    /// identifies weather a item is selected or not.
    required ValidateSelectedItem<T> validateSelectedItem,

    /// The `validateRemoveItem` identifies if a item should be remove or not and returns the list filtered.
    ValidateRemoveItem<T>? validateRemoveItem,

    /// filter list on the basis of search field text.
    /// When text change in search text field then return list containing that text value.
    ///
    ///Check if list has value which matches to text.
    required SearchPredict<T> onItemSearch,

    /// Return list of all selected items
    required OnApplyButtonClick<T> onApplyButtonClick,

    /// Height of the dialog
    double? height,

    /// Width of the dialog
    double? width,

    /// Border radius of dialog.
    double borderRadius = 20,

    /// Headline text to be display as header of dialog.
    String? headlineText,

    /// Used to hide selected text count.
    bool hideSelectedTextCount = false,

    /// Used to hide search field.
    bool hideSearchField = false,

    /// Used to hide close icon.
    bool hideCloseIcon = false,

    /// Widget to close the dialog.
    ///
    /// If widget is not provided then default close icon will be used.
    final Widget? headerCloseIcon,

    /// Function to execute on close widget press. To pass user define function and do a different task with this button rather than close. (Example: Add item to the List.)
    ///
    /// Default is `Navigator.pop(context, null)`
    final void Function()? onCloseWidgetPress,

    /// Used to hide header.
    bool hideHeader = false,

    /// The `barrierDismissible` argument is used to indicate whether tapping on the barrier will dismiss the dialog.
    ///
    ///  It is true by default and can not be null.
    bool barrierDismissible = true,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,

    /// if `enableOnlySingleSelection` is true then it disabled the multiple selection.
    /// and enabled the single selection model.
    ///
    /// Default value is [false]
    bool enableOnlySingleSelection = false,

    /// if `maximumSelectionLength` is not null then it will limit the maximum selection length.
    /// `maximumSelectionLength` should be greater than 0. If `maximumSelectionLength` is less than 0 then it will throw an exception.
    /// Only works when `enableOnlySingleSelection` is false.
    /// Default value is [null]
    int? maximumSelectionLength,

    /// Background color of dialog box.
    Color backgroundColor = Colors.white,

    /// Apply Button Label
    String? applyButtonText = 'Apply',

    /// Reset Button Label
    String? resetButtonText = 'Reset',

    /// All Button Label
    String? allButtonText = 'All',

    /// Selected items count text
    String? selectedItemsText = 'selected items',

    /// The amount of padding added to [MediaQueryData.viewInsets] on the outside of the dialog.
    /// This defines the minimum space between the screen's edges and the dialog.
    ///
    /// Defaults to EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0).
    EdgeInsets? insetPadding =
        const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),

    /// The `choiceChipBuilder` is a builder to design custom choice chip.
    ChoiceChipBuilder? choiceChipBuilder,

    /// {@macro control_buttons}
    List<core_types.ControlButtonType>? controlButtons,
  }) async {
    height ??= MediaQuery.of(context).size.height * .5;
    width ??= MediaQuery.of(context).size.width;
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      routeSettings: routeSettings,
      useRootNavigator: useRootNavigator,
      useSafeArea: useSafeArea,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: insetPadding,
          child: Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(themeData?.borderRadius ?? 20),
              ),
              child: FilterListWidget(
                themeData: themeData,
                listData: listData,
                choiceChipLabel: choiceChipLabel,
                hideHeader: hideHeader,
                headlineText: headlineText,
                onItemSearch: onItemSearch,
                backgroundColor: backgroundColor,
                selectedListData: selectedListData,
                onApplyButtonClick: onApplyButtonClick,
                validateSelectedItem: validateSelectedItem,
                hideSelectedTextCount: hideSelectedTextCount,
                hideCloseIcon: hideCloseIcon,
                headerCloseIcon: headerCloseIcon,
                onCloseWidgetPress: onCloseWidgetPress,
                hideSearchField: hideSearchField,
                choiceChipBuilder: choiceChipBuilder,
                enableOnlySingleSelection: enableOnlySingleSelection,
                selectedItemsText: selectedItemsText,
                applyButtonText: applyButtonText,
                resetButtonText: resetButtonText,
                allButtonText: allButtonText,
                validateRemoveItem: validateRemoveItem,
                maximumSelectionLength: maximumSelectionLength,
                controlButtons: controlButtons ??
                    [
                      core_types.ControlButtonType.All,
                      core_types.ControlButtonType.Reset,
                      core_types.ControlButtonType.Apply
                    ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Modern implementation of FilterListDialog using the FilterCore, FilterCallbacks, and FilterUIConfig components
  /// for a more modular and maintainable approach.
  ///
  /// Example:
  /// ```dart
  /// await FilterListDialog.showWithCore<User>(
  ///   context,
  ///   allItems: userList,
  ///   selectedItems: selectedUserList,
  ///   callbacks: FilterCallbacks(
  ///     searchPredicate: (user, query) => user.name.toLowerCase().contains(query.toLowerCase()),
  ///     labelProvider: (user) => user?.name,
  ///     validateSelection: (list, item) => list!.contains(item),
  ///     onApplyButtonClick: (list) {
  ///       setState(() { selectedUserList = List.from(list!); });
  ///       Navigator.pop(context);
  ///     },
  ///   ),
  ///   uiConfig: FilterUIConfig(
  ///     headlineText: 'Select Users',
  ///     searchFieldHint: 'Search users...',
  ///   ),
  /// );
  /// ```
  static Future showWithCore<T extends Object>(
    BuildContext context, {
    /// List of all items to filter
    required List<T> allItems,

    /// Initially selected items
    List<T>? selectedItems,

    /// Callbacks for filtering operations
    required FilterCallbacks<T> callbacks,

    /// UI configuration options
    FilterUIConfig? uiConfig,

    /// Theme data for filter dialog
    FilterListThemeData? themeData,

    /// Height of the dialog
    double? height,

    /// Width of the dialog
    double? width,

    /// Custom choice chip builder
    ChoiceChipBuilder? choiceChipBuilder,

    /// Dialog configuration
    bool barrierDismissible = true,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    EdgeInsets? insetPadding =
        const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
  }) async {
    height ??= MediaQuery.of(context).size.height * .5;
    width ??= MediaQuery.of(context).size.width;

    // Use default UI config if not provided
    final config = uiConfig ?? const FilterUIConfig();

    // Initialize the filter core with the provided data and callbacks
    final filterCore = FilterCore<T>(
      allItems: allItems,
      selectedItems: selectedItems,
      searchPredicate: callbacks.searchPredicate,
      validateSelection: callbacks.validateSelection,
      validateRemoveItem: callbacks.validateRemoveItem,
      onApplyButtonClick: callbacks.onApplyButtonClick,
      maximumSelectionLength: config.enableOnlySingleSelection ? 1 : null,
    );

    // Convert core ControlButtonType to widget ControlButtonType
    final List<core_types.ControlButtonType> convertedButtons = [];
    for (final button in config.controlButtons) {
      if (button == core_types.ControlButtonType.All) {
        convertedButtons.add(core_types.ControlButtonType.All);
      } else if (button == core_types.ControlButtonType.Reset) {
        convertedButtons.add(core_types.ControlButtonType.Reset);
      } else if (button == core_types.ControlButtonType.Apply) {
        convertedButtons.add(core_types.ControlButtonType.Apply);
      }
    }

    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      routeSettings: routeSettings,
      useRootNavigator: useRootNavigator,
      useSafeArea: useSafeArea,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: insetPadding,
          child: Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(themeData?.borderRadius ?? 20),
              ),
              child: FilterListWidget(
                themeData: themeData,
                listData: allItems,
                choiceChipLabel: callbacks.labelProvider,
                hideHeader: config.hideHeader,
                headlineText: config.headlineText,
                onItemSearch: callbacks.searchPredicate,
                backgroundColor: config.backgroundColor,
                selectedListData: selectedItems,
                onApplyButtonClick: callbacks.onApplyButtonClick,
                validateSelectedItem: callbacks.validateSelection,
                hideSelectedTextCount: config.hideSelectedTextCount,
                hideCloseIcon: config.hideCloseIcon,
                headerCloseIcon: config.closeIcon,
                onCloseWidgetPress: config.onClosePressed,
                hideSearchField: config.hideSearchField,
                choiceChipBuilder: choiceChipBuilder,
                enableOnlySingleSelection: config.enableOnlySingleSelection,
                selectedItemsText: config.selectedItemsText,
                applyButtonText: config.applyButtonText,
                resetButtonText: config.resetButtonText,
                allButtonText: config.allButtonText,
                validateRemoveItem: callbacks.validateRemoveItem,
                controlButtons: convertedButtons,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Shows a dialog with the modern implementation of the filter list.
  ///
  /// This method uses the new Provider-based state management system with
  /// the FilterListWidgetModern for better performance and maintainability.
  static Future<List<T>?> showFilterListModern<T extends Object>(
    BuildContext context, {
    /// Filter list theme data
    FilterListThemeData? themeData,

    /// List of all items to filter
    required List<T> listData,

    /// Initially selected items
    List<T>? selectedListData,

    /// Custom choice chip builder
    ChoiceChipBuilder? choiceChipBuilder,

    /// Function to get the label text for an item
    required LabelDelegate<T> labelProvider,

    /// Function to validate if an item is selected
    required ValidateSelectedItem<T> validateSelection,

    /// Function to handle the removal of items
    ValidateRemoveItem<T>? validateRemoveItem,

    /// Function to search/filter items by query
    required SearchPredict<T> searchPredicate,

    /// Callback when the apply button is clicked
    required OnApplyButtonClick<T> onApplyButtonClick,

    /// Height of the dialog
    double? height,

    /// Width of the dialog
    double? width,

    /// Border radius of the dialog
    double borderRadius = 20,

    /// Headline text to display in the header
    String? headlineText,

    /// Whether to hide the selected text count
    bool hideSelectedTextCount = false,

    /// Whether to hide the search field
    bool hideSearchField = false,

    /// Whether to hide the close icon
    bool hideCloseIcon = false,

    /// Custom close icon widget
    Widget? headerCloseIcon,

    /// Custom function to execute when close widget is pressed
    void Function()? onCloseWidgetPress,

    /// Whether to hide the header
    bool hideHeader = false,

    /// Whether tapping on the barrier dismisses the dialog
    bool barrierDismissible = true,

    /// Whether to use safe area
    bool useSafeArea = true,

    /// Whether to use root navigator
    bool useRootNavigator = true,

    /// Route settings
    RouteSettings? routeSettings,

    /// Whether to enable single selection only
    bool enableOnlySingleSelection = false,

    /// Maximum selection length
    int? maximumSelectionLength,

    /// Background color
    Color backgroundColor = Colors.white,

    /// Apply button text
    String applyButtonText = 'Apply',

    /// Reset button text
    String resetButtonText = 'Reset',

    /// All button text
    String allButtonText = 'All',

    /// Selected items text
    String selectedItemsText = 'selected items',

    /// Inset padding
    EdgeInsets? insetPadding =
        const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),

    /// Control buttons to display
    List<core_types.ControlButtonType>? controlButtons,

    /// Duration to debounce search queries
    Duration? debounceDuration,
  }) async {
    // Default height and width based on screen size
    height ??= MediaQuery.of(context).size.height * .5;
    width ??= MediaQuery.of(context).size.width;

    // Create UI configuration
    final config = FilterUIConfig(
      headlineText: headlineText,
      hideSelectedTextCount: hideSelectedTextCount,
      hideSearchField: hideSearchField,
      hideCloseIcon: hideCloseIcon,
      hideHeader: hideHeader,
      closeIcon: headerCloseIcon,
      onClosePressed: onCloseWidgetPress,
      enableOnlySingleSelection: enableOnlySingleSelection,
      applyButtonText: applyButtonText,
      resetButtonText: resetButtonText,
      allButtonText: allButtonText,
      selectedItemsText: selectedItemsText,
      controlButtons: controlButtons ??
          [
            core_types.ControlButtonType.Reset,
            core_types.ControlButtonType.All,
            core_types.ControlButtonType.Apply,
          ],
    );

    // Create controller
    final controller = FilterListController<T>(
      allItems: listData,
      selectedItems: selectedListData,
      searchPredicate: searchPredicate,
      validateSelection: validateSelection,
      validateRemoveItem: validateRemoveItem,
      onApplyButtonClick: onApplyButtonClick,
      maximumSelectionLength: maximumSelectionLength,
      uiConfig: config,
      debounceDuration: debounceDuration,
    );

    // Show dialog with the modern filter list implementation
    return await showDialog<List<T>>(
      context: context,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: insetPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: backgroundColor,
            ),
            child: FilterListProvider<T>(
              controller: controller,
              child: FilterListWidgetModern<T>(
                themeData: themeData,
                choiceChipBuilder: choiceChipBuilder,
              ),
            ),
          ),
        );
      },
    );
  }
}
