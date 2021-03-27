library filter_list;

import 'package:filter_list/src/choice_chip_widget.dart';
import 'package:filter_list/src/search_field_widget.dart';
import 'package:flutter/material.dart';

part 'src/filter_list_widget.dart';

/// {@tool snippet}
///
/// This example shows how to use [FilterListDialog]
///
//  ``` dart
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
///         /// When text change in search text field then return list containing that text value
///         ///
///         ///Check if list has value which matchs to text
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
///             selectedUserList = List.from(list);
///           });
///           Navigator.pop(context);
///         }
///       });
/// }
/// ```
/// {@end-tool}
///
class FilterListDialog {
  static Future<List<T>> display<T extends Object>(
    context, {

    /// Pass list containing all data which neeeds to filter
    @required List<T> listData,

    /// pass selected list of object
    /// every object on selecteListData should be present in list data
    List<T> selectedListData,

    /// Print text on chip
    @required String Function(T b) label,

    /// identifies weather a item is selecte or not
    @required bool Function(List<T> a, T b) validateSelectedItem,

    /// filter list on the basis of search field text
    @required List<T> Function(List<T> list, String text) onItemSearch,

    /// Return list of all selected items
    @required Function(List<T>) onApplyButtonClick,
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
    Color headerTextColor = Colors.black,
    Color applyButonTextColor = Colors.white,
    Color applyButonTextBackgroundColor = Colors.blue,
    Color allResetButonColor = Colors.blue,
    Color selectedTextColor = Colors.white,
    Color backgroundColor = Colors.white,
    Color unselectedTextColor = Colors.black,
    Color searchFieldBackgroundColor = const Color(0xfff5f5f5),
    Color selectedTextBackgroundColor = Colors.blue,
    Color unselectedTextbackGroundColor = const Color(0xfff8f8f8),
    String applyButonText = 'Apply',
    String allButonText = 'All',
    String resetButonText = 'Reset',
    String selectedItemsText = 'selected items',
  }) async {
    if (height == null) {
      height = MediaQuery.of(context).size.height * .8;
    }
    if (width == null) {
      width = MediaQuery.of(context).size.width;
    }
    var list = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: FilterListWidget(
              onApplyButtonClick: onApplyButtonClick,
              validateSelectedItem: validateSelectedItem,
              listData: listData,
              label: label,
              selectedListData: selectedListData,
              onItemSearch: onItemSearch,
              height: height,
              width: width,
              borderRadius: borderRadius,
              headlineText: headlineText,
              searchFieldHintText: searchFieldHintText,
              allResetButonColor: allResetButonColor,
              applyButonTextBackgroundColor: applyButonTextBackgroundColor,
              applyButonTextColor: applyButonTextColor,
              backgroundColor: backgroundColor,
              closeIconColor: closeIconColor,
              headerTextColor: headerTextColor,
              searchFieldBackgroundColor: searchFieldBackgroundColor,
              selectedTextBackgroundColor: selectedTextBackgroundColor,
              selectedTextColor: selectedTextColor,
              hideSelectedTextCount: hideSelectedTextCount,
              unselectedTextbackGroundColor: unselectedTextbackGroundColor,
              unselectedTextColor: unselectedTextColor,
              hidecloseIcon: hidecloseIcon,
              hideHeader: hideheader,
              hideheaderText: hideheaderText,
              hideSearchField: hideSearchField,
              allButonText: allButonText,
              applyButonText: applyButonText,
              resetButonText: resetButonText,
              selectedItemsText: selectedItemsText,
            ),
          ),
        );
      },
    );
    return list;
  }
}
