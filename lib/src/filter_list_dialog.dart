library filter_list;

import 'package:filter_list/src/widget/choice_chip_widget.dart';
import 'package:filter_list/src/widget/search_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'filter_list_widget.dart';

class FilterListDialog {
  /// {@tool snippet}
  ///
  /// This example shows how to use [FilterListDialog]
  ///
  ///  ``` dart
  /// void _openFilterDialog() async {
  ///   await FilterListDialog.display(context,
  ///       listData: ["One", "Two", "Three", "Four","five","Six","Seven","Eight","Nine","Ten"],
  ///       selectedListData: ["One", "Three", "Four","Eight","Nine"],
  ///       label: (item) {
  ///         return item;
  ///       },
  ///       validateSelectedItem: (list, val) {
  ///         return list.contains(val);
  ///       },
  ///       onItemSearch: (list, text) {
  ///         if (list.any((element) =>
  ///             element.toLowerCase().contains(text.toLowerCase()))) {
  ///           /// return list which contains matches
  ///           return list
  ///               .where((element) =>
  ///                   element.toLowerCase().contains(text.toLowerCase()))
  ///               .toList();
  ///         }
  ///       },
  ///       height: 480,
  ///       borderRadius: 20,
  ///       headlineText: "Select Count",
  ///       searchFieldHintText: "Search Here",
  ///       onApplyButtonClick: (list) {
  ///         if (list != null) {
  ///           setState(() {
  ///            var selectedList = List.from(list);
  ///           });
  ///           Navigator.pop(context);
  ///         }
  ///       });
  /// }
  /// ```
  /// {@end-tool}
  ///
  static Future display<T>(context,
      {

      /// Pass list containing all data which neeeds to filter
      @required List<T> listData,

      /// pass selected list of object
      /// every object on selecteListData should be present in list data
      List<T> selectedListData,

      /// Display text value on choice chip
      @required String Function(T b) label,

      /// identifies weather a item is selecte or not
      @required ValidateSelectedItem<T> validateSelectedItem,

      /// filter list on the basis of search field text
      /// When text change in search text field then return list containing that text value
      ///
      ///Check if list has value which matches to text
      @required List<T> Function(List<T> list, String text) onItemSearch,

      /// Return list of all selected items
      @required OnApplyButtonClick<T> onApplyButtonClick,
      double height,
      double width,
      double borderRadius = 20,
      String headlineText = "Select",
      String searchFieldHintText = "Search here",
      bool hideSelectedTextCount = false,
      bool hideSearchField = false,
      bool hidecloseIcon = false,
      bool hideheader = false,
      bool hideheaderText = false,
      Color closeIconColor = Colors.black,
      bool barrierDismissible = true,
      bool useSafeArea = true,
      bool useRootNavigator = true,
      RouteSettings routeSettings,

      /// if `enableOnlySingleSelection` is true then it disabled the multiple selection
      /// and enabled the single selection model.
      ///
      /// Defautl value is `false`
      bool enableOnlySingleSelection = false,

      /// Background color of dialog box
      Color backgroundColor = Colors.white,

      /// Background color for search field
      Color searchFieldBackgroundColor = const Color(0xfff5f5f5),

      /// Background color for Apply button
      Color applyButonTextBackgroundColor = Colors.blue,

      /// TextStyle for chip when selected
      TextStyle selectedChipTextStyle,

      /// TextStyle for chip when not selected
      TextStyle unselectedChipTextStyle,

      /// TextStyle for `All` and `Reset` button text
      TextStyle controlButtonTextStyle,

      /// TextStyle for `Apply` button
      TextStyle applyButtonTextStyle,

      /// TextStyle for header text
      TextStyle headerTextStyle,

      /// TextStyle for search field text
      TextStyle searchFieldTextStyle,

      /// Builder for custom choice chip
      ChoiceChipBuilder choiceChipBuilder}) async {
    assert(validateSelectedItem != null, ''' 
            validateSelectedItem callback can not be null

            Tried to use below callback to ignore error.

             validateSelectedItem: (list, val) {
                  return list.contains(val);
             }
            ''');
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
          child: Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: FilterListWidget(
              listData: listData,
              label: label,
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
              hidecloseIcon: hidecloseIcon,
              hideheaderText: hideheaderText,
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
            ),
          ),
        );
      },
    );
  }
}
