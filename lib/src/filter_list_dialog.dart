library filter_list;

import 'package:filter_list/src/widget/choice_chip_widget.dart';
import 'package:filter_list/src/widget/search_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'filter_list_widget.dart';

/// The [FilterListDialog.display()] is a [Dialog] with some filter utilities and callbacks which helps in single/multiple selection from list of data.
///
/// {@template arguments}
/// The [listData] should be list of dynamic data which neeeds to filter.
///
/// The [selectedListData] should be subset of [listData]. The list passed to [selectedListData] should available in [listData].
///
/// The [choiceChipLabel] is a callback which required [String] value in return. It used this value to display text on choice chip.
///
/// The [validateSelectedItem] used to identifies weather a item is selecte or not.
///
/// [onItemSearch] filter the list on the basis of search field text. It expose search api to permform search operation accoding to requirement.
/// When text change in search text field then return a list of element which contains specific text. if no element found then it should return empty list.
///
/// ```dart
///    onItemSearch: (list, text) {
///     if (list.any((element) =>
///         element.toLowerCase().contains(text.toLowerCase()))) {
///       /// return list which contains matches
///       return list
///           .where((element) =>
///               element.toLowerCase().contains(text.toLowerCase()))
///           .toList();
///     }
///   },
/// ```
///
/// The [choiceChipBuilder] is a builder to design custom choice chip.
///
///
/// The [onApplyButtonClick] is a callback which return list of all selected items on apply button click.  if no item is selected then it will return empty list.
/// {@endtemplate}
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
///        onItemSearch: (list, text) {
///          if (list!.any((element) =>
///              element.toLowerCase().contains(text.toLowerCase()))) {
///            /// return list which contains text matches
///            return list
///                .where((element) =>
///                    element.toLowerCase().contains(text.toLowerCase()))
///                .toList();
///          }
///          return [];
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

class FilterListDialog {
  static Future display<T>(
    context, {

    /// Pass list containing all data which neeeds to filter.
    required List<T> listData,

    /// pass selected list of object
    /// every object on selecteListData should be present in list data.
    List<T>? selectedListData,

    /// Display text on choice chip.
    required LabelDelegate<T> choiceChipLabel,

    /// identifies weather a item is selecte or not.
    required ValidateSelectedItem<T> validateSelectedItem,

    /// The `validateRemoveItem` identifies if a item should be remove or not and returns the list filtered.
    ValidateRemoveItem<T>? validateRemoveItem,

    /// filter list on the basis of search field text.
    /// When text change in search text field then return list containing that text value.
    ///
    ///Check if list has value which matches to text.
    required ItemSearchDelegate<T> onItemSearch,

    /// Return list of all selected items
    required OnApplyButtonClick<T> onApplyButtonClick,

    /// Height of the dialog
    double? height,

    /// Width of the dialog
    double? width,

    /// Border radius of dialog.
    double borderRadius = 20,

    /// Headline text to be display as header of dialog.
    String headlineText = "Select",

    /// Hint text for search field.
    String searchFieldHintText = "Search here",

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

    /// Used to hide header.
    bool hideheader = false,

    /// Used to hide header text.
    bool hideHeaderText = false,

    /// Hide header area shadow if value is true
    ///
    /// By default it is false
    final bool? hideHeaderAreaShadow,

    ///Color of close icon
    Color closeIconColor = Colors.black,
    Color headerTextColor = Colors.black,
    Color selectedTextBackgroundColor = Colors.blue,
    Color unselectedTextbackGroundColor = const Color(0xfff8f8f8),

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
    /// Defautl value is [false]
    bool enableOnlySingleSelection = false,

    /// Background color of dialog box.
    Color backgroundColor = Colors.white,

    /// Background color for search field.
    Color searchFieldBackgroundColor = const Color(0xfff5f5f5),

    /// Background color for Apply button.
    Color applyButonTextBackgroundColor = Colors.blue,

    /// TextStyle for chip when selected.
    TextStyle? selectedChipTextStyle,

    /// TextStyle for chip when not selected.
    TextStyle? unselectedChipTextStyle,

    /// TextStyle for [All] and [Reset] button text.
    TextStyle? controlButtonTextStyle,

    /// TextStyle for [Apply] button.
    TextStyle? applyButtonTextStyle,

    /// TextStyle for header text.
    TextStyle? headerTextStyle,

    /// TextStyle for search field text.
    TextStyle? searchFieldTextStyle,

    /// Apply Button Label
    String? applyButtonText = 'Apply',

    /// Reset Button Label
    String? resetButtonText = 'Reset',

    /// All Button Label
    String? allButtonText = 'All',

    /// Selected items count text
    String? selectedItemsText = 'selected items',

    /// Control container box decoration
    BoxDecoration? controlContainerDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(25)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(0, 5),
          blurRadius: 15,
          color: Color(0x12000000),
        )
      ],
    ),

    /// Button radius
    double? buttonRadius,

    /// Spacing between control buttons
    double? buttonSpacing,

    /// The amount of padding added to [MediaQueryData.viewInsets] on the outside of the dialog.
    /// This defines the minimum space between the screen's edges and the dialog.
    ///
    /// Defaults to EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0).
    EdgeInsets? insetPadding =
        const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),

    /// The `choiceChipBuilder` is a builder to design custom choice chip.
    ChoiceChipBuilder? choiceChipBuilder,

    /// How the choice chip within a run should be placed in the main axis.
    /// For example, if [wrapSpacing] is [WrapAlignment.center], the choice chip in each run are grouped together in the center of their run in the main axis.
    ///
    /// Defaults to [WrapAlignment.start].
    WrapAlignment wrapAlignment = WrapAlignment.start,

    /// How the choice chip within a run should be aligned relative to each other in the cross axis.
    ///For example, if this is set to [WrapCrossAlignment.end], and the [direction] is [Axis.horizontal], then the choice chip within each run will have their bottom edges aligned to the bottom edge of the run.
    ///
    ///Defaults to [WrapCrossAlignment.start].
    WrapCrossAlignment wrapCrossAxisAlignment = WrapCrossAlignment.start,

    ///How much space to place between choice chip in a run in the main axis.
    ///For example, if [wrapSpacing] is 10.0, the choice chip will be spaced at least 10.0 logical pixels apart in the main axis.
    ///If there is additional free space in a run (e.g., because the wrap has a minimum size that is not filled or because some runs are longer than others), the additional free space will be allocated according to the [alignment].
    ///
    ///Defaults to 0.0.
    double wrapSpacing = 0.0,
  }) async {
    if (height == null) {
      height = MediaQuery.of(context).size.height * .8;
    }
    if (width == null) {
      width = MediaQuery.of(context).size.width;
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
            child: FilterListWidget(
              listData: listData,
              choiceChipLabel: choiceChipLabel,
              width: width,
              height: height,
              hideHeader: hideheader,
              borderRadius: borderRadius,
              headlineText: headlineText,
              onItemSearch: onItemSearch,
              closeIconColor: closeIconColor,
              headerTextStyle: headerTextStyle,
              backgroundColor: backgroundColor,
              selectedListData: selectedListData,
              onApplyButtonClick: onApplyButtonClick,
              validateSelectedItem: validateSelectedItem,
              hideSelectedTextCount: hideSelectedTextCount,
              hideCloseIcon: hideCloseIcon,
              hideHeaderAreaShadow: hideHeaderAreaShadow,
              headerCloseIcon: headerCloseIcon,
              hideHeaderText: hideHeaderText,
              hideSearchField: hideSearchField,
              choiceChipBuilder: choiceChipBuilder,
              searchFieldHintText: searchFieldHintText,
              applyButtonTextStyle: applyButtonTextStyle,
              searchFieldTextStyle: searchFieldTextStyle,
              selectedChipTextStyle: selectedChipTextStyle,
              controlButtonTextStyle: controlButtonTextStyle,
              unselectedChipTextStyle: unselectedChipTextStyle,
              enableOnlySingleSelection: enableOnlySingleSelection,
              searchFieldBackgroundColor: searchFieldBackgroundColor,
              applyButonTextBackgroundColor: applyButonTextBackgroundColor,
              selectedItemsText: selectedItemsText,
              applyButtonText: applyButtonText,
              resetButtonText: resetButtonText,
              allButtonText: allButtonText,
              buttonRadius: buttonRadius,
              controlContainerDecoration: controlContainerDecoration,
              buttonSpacing: buttonSpacing,
              validateRemoveItem: validateRemoveItem,
              headerTextColor: headerTextColor,
              selectedTextBackgroundColor: selectedTextBackgroundColor,
              unselectedTextbackGroundColor: unselectedTextbackGroundColor,
              wrapAlignment: wrapAlignment,
              wrapCrossAxisAlignment: wrapCrossAxisAlignment,
              wrapSpacing: wrapSpacing,
            ),
          ),
        );
      },
    );
  }
}
